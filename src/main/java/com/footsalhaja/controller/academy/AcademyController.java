package com.footsalhaja.controller.academy;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URLEncoder;

import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.domain.academy.PageDto;
import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.academy.AcademyServiceImpl;
import com.footsalhaja.service.member.MemberService;

import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.core.ResponseBytes;

import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;



import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;


import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;


@Controller
@RequestMapping("academy")
public class AcademyController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AcademyServiceImpl service;
	
	@Autowired
	private AwsCredentials awsCredentials;
	
	@Autowired
	public AwsCredentialsProvider awsCredentialsProvider;
	
	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;
	
	//list ??????
	@GetMapping("list")
	public void list(@RequestParam(name = "category", defaultValue = "") String category, BoardDto board,
			Criteria cri, Model model) {
	
		// request param
		// business logic

		String keyword = cri.getKeyword();
		cri.setKeyword("%"+cri.getKeyword()+"%");
		List<BoardDto> list = service.listBord(cri, category);
		
		System.out.println(list);
		System.out.println("category:"+ category);
		
		// add attribute
		model.addAttribute("boardList", list);
		
		//?????? ???????????? ??? ????????? ??????????????????
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDto(cri, total));
		// forward
		
		cri.setKeyword(keyword);
		
		// ????????? ??????
		List<BoardDto> rank = service.likeRank(board); 
		model.addAttribute("likeRank", rank);
		
	}
	
	@GetMapping(value ="{userId}/profileImg", produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> myGetAndModifyWithProFile(@PathVariable(name="userId") String userId) throws Exception {
		
		
		//RequestParam ?????? member/get?userId= ???????????? ???????????? db ?????? -> MemberDto ?????? member ->  addAttribute "member" ?????? . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId = (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		
		//????????? ????????? ?????????

		InputStream imageStream = new FileInputStream("user_profile/" + userId + "/" + memberInfoByUserId.getProfileImg());
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		

		System.out.println("????????? "+imageByteArray);
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
		
	}
	
	//register ??????
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(BoardDto board, MultipartFile[] files,
			RedirectAttributes rttr) {
		
		// request param ??????/??????
		
		// business logic
		service.insertFile(board, files);
		
		/* service.insert(board); */
		
				
		return "redirect:/academy/list";
	}
	
	
	//???????????? ????????? ?????????
	  @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	  
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(BoardDto board,@RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String ab_filePath = "academy/" + board.getAb_number(); //????????? ?????? ?????? ?????? String
	  String originalFileName = multipartFile.getOriginalFilename(); //???????????? ????????? String
	  
	  String ab_image = UUID.randomUUID() + originalFileName; //?????? UUID+?????????????????? ????????? ?????? ??? ??????
	  

	  System.out.println(ab_filePath);
	  
	  try {
			// putObjectRequest
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(ab_filePath)
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			// requestBody
			InputStream fileStream = multipartFile.getInputStream();
			software.amazon.awssdk.core.sync.RequestBody requestBody = software.amazon.awssdk.core.sync.RequestBody.fromInputStream(fileStream, multipartFile.getSize());
			
			// object(??????) ?????????
			s3Client.putObject(putObjectRequest, requestBody);
	
			//???????????? ????????? ?????? ?????? presigned URL ??????
			  Regions clientRegion = Regions.AP_NORTHEAST_2;
			  
			  AWSCredentials credentials = new BasicAWSCredentials(awsCredentials.accessKeyId(), awsCredentials.secretAccessKey());
			  
			  AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
			  .withRegion(clientRegion)
			  .withCredentials(new AWSStaticCredentialsProvider(credentials))
			  .build();
			  
			  
			  // Set the presigned URL to expire after 12 hours. 
			  java.util.Date expiration = new java.util.Date(); 
			  long expTimeMillis = Instant.now().toEpochMilli();
			  expTimeMillis += 1000 * 60 * 60 *12; 
			  expiration.setTime(expTimeMillis);
			  
			  // Generate the presigned URL.
			  System.out.println("Generating pre-signed URL."); 
			  GeneratePresignedUrlRequest generatePresignedUrlRequest = new GeneratePresignedUrlRequest(bucketName,ab_filePath)
					  .withMethod(HttpMethod.GET)
			  .withExpiration(expiration);
			  
			  String url =s3Client.generatePresignedUrl(generatePresignedUrlRequest).toString();
			  
			  System.out.println(url);
			 
			//url??? s3 bucket ?????? ????????? ?????? ???????????????... s3??? ????????? presignedUrl?????? ??????


			jsonObject.put("url", url);
			jsonObject.put("ab_image", ab_image);
			jsonObject.put("responseCode", "success");
			
			
		} catch (Exception e) {  
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	 
	  
	  return jsonObject;
	  }
	  

	
	//get ?????????
	@GetMapping("get")
	public void get (@RequestParam("ab_number") int ab_number, Model model, @ModelAttribute("cri") Criteria cri, Authentication authentication) {
		String member_userId = null;
		
		if (authentication != null) {
			member_userId = authentication.getName();
		}
		
		service.updateViewCount(ab_number);
		BoardDto board = service.get(ab_number, member_userId);
		
		model.addAttribute("board",board);
	
		//RequestParam ?????? member/get?userId= ???????????? ???????????? db ?????? -> MemberDto ?????? member ->  addAttribute "member" ?????? . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId =  (MemberDto) memberService.selectMemberInfoByUserId(member_userId).get(0);
		System.out.println("???????????? :"+memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
	}
	
	//modify ?????????
	@PreAuthorize("@boardSecurity.checkWriter2(authentication.name, #ab_number)")
	@GetMapping("modify")
	public void modify(int ab_number, Model model) {
		BoardDto board = service.get(ab_number);
		model.addAttribute("board",board);
	}
	
	@PreAuthorize("@boardSecurity.checkWriter2(authentication.name, #board.ab_number)")
	@PostMapping("modify")
	public String modify(BoardDto board, @RequestParam("files") MultipartFile[] addFiles,
			@RequestParam(name = "removeFiles", required = false) List<String> removeFiles) {
		service.modify(board, addFiles,removeFiles);
		int num = board.getAb_number();
		return "redirect:/academy/get?ab_number=" + num;
	}
	
	//remove ?????????
	@PreAuthorize("@boardSecurity.checkWriter2(authentication.name, #ab_number)")
	@PostMapping("remove") 
	public String remove(int ab_number) {
		service.remove(ab_number);
		
		return "redirect:/academy/list";
	}
	
	//????????? ??????
	@PutMapping("like")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> like(@RequestBody Map<String, String> req,
			Authentication authentication) {
		
		Map<String, Object> result = service.updateLike(req.get("ab_number"), authentication.getName());
		
		return result;
	}
	
	//?????? ????????????
	@GetMapping("download/{ab_number}/{filename}")
	@ResponseBody
	//???????????? ???????????? ????????? ?????? ?????? HttpServletResponse ??? ??????
	public void  downloadFile(@PathVariable("ab_number") int ab_number,
								@PathVariable String filename, HttpServletResponse response) throws Exception {
		
		//???????????? ?????? ?????? ??????
		/*
		 * File downloadFile = new File("academy/"+ab_number+"/"+filename);
		 */
		//????????? byte ????????? ??????
		/* byte fileByte[] = FileUtils.readFileToByteArray(downloadFile); */
		
		
		String originalFileName = filename.substring(36);
		
		//getObjectRequest(?????? ???????????? ?????? ??????)
		GetObjectRequest getObjectRequest = GetObjectRequest.builder()
				.bucket(bucketName)
				.key("academy/"+ab_number+"/"+originalFileName)
				.build();
		
		ResponseBytes<GetObjectResponse> obj = s3Client.getObjectAsBytes(getObjectRequest);
		
		System.out.println("obj : " + obj);
		
		byte[] fileByte = obj.asByteArray();
		
		//"application/octet-stream" ??? ???????????? ???????????? ?????? ???????????? ?????? ????????????, ?????????????????? ????????? ??????????????? ??????
		response.setContentType("application/octet-stream");
		
		//?????? ???????????? ??????
        response.setContentLength(fileByte.length);
		response.setHeader("Content-Type", "application/octet-stream;");
		
		//??????????????? ?????? ????????? ??????(UUID??????)
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8") +"\";");
		
		//"application/octet-stream"??? binary ??????????????? ????????? binary??? ?????????
        response.setHeader("Content-Transfer-Encoding", "binary");
		
        //????????? ????????? ?????? ??????????????? ??????
        response.getOutputStream().write(fileByte);
        //????????? ????????? ????????? ?????????????????? ???????????? ????????? ?????????.
        response.getOutputStream().flush();
        //?????? ???????????? ??????
        response.getOutputStream().close();
        
	}
	
}
