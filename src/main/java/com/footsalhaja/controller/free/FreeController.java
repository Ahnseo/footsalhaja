package com.footsalhaja.controller.free;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.PageInfo;
import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.free.FreeService;
import com.footsalhaja.service.member.MemberService;

import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Controller
@RequestMapping("free")
public class FreeController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FreeService service;
	
	@Autowired
	private AwsCredentials awsCredentials;
	
	@Autowired
	public AwsCredentialsProvider awsCredentialsProvider;
	
	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;
	
	
	@GetMapping(value ="{userId}/profileImg", produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> myGetAndModifyWithProFile(@PathVariable(name="userId") String userId) throws Exception {
		
		
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId = (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		
		//프로필 이미지 보이기

		InputStream imageStream = new FileInputStream("user_profile/" + userId + "/" + memberInfoByUserId.getProfileImg());
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		

		System.out.println("이미지 "+imageByteArray);
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
		
	}
	
	@GetMapping("insert")
	public void insert() {
		
	}
	
	@PostMapping("insert")
	public String insert(BoardDto board, MultipartFile[] files,
			RedirectAttributes rttr) {
		
		service.insertFile(board, files);
		
		return "redirect:/free/list";
	}
	
	
	@GetMapping("list")
	public void list(
			@RequestParam(name = "page", defaultValue = "1") int page, // 페이지
			@RequestParam(name = "t", defaultValue = "all") String type, // 검색범위(카테고리)
			@RequestParam(name = "q", defaultValue = "") String keyword, // 검색어
			@RequestParam(name = "category", defaultValue = "") String category, // 카테고리
			PageInfo pageInfo,
			Model model,
			BoardDto board) {
		
		// 목록
		List<BoardDto> list = service.listBoard(page, type, keyword, pageInfo, category);
		model.addAttribute("boardList", list);
		
		// 좋아요 순위
		List<BoardDto> rank = service.likeRank(board); 
		model.addAttribute("likeRank", rank);
	}


	@GetMapping("get")
	public void get(
			@RequestParam(name = "number") int fb_number,
			Authentication auth,
			Model model) {
		String member_userId = null;
		 
		if (auth != null) {
			member_userId = auth.getName();
		}
		// 조회수
		service.updateViewCount(fb_number);
		
		BoardDto board = service.get(fb_number, member_userId);
		model.addAttribute("board", board);
		
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId =  (MemberDto) memberService.selectMemberInfoByUserId(member_userId).get(0);
		System.out.println("멤버인포 :"+memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
		
	}
	
	
	@GetMapping("modify") // @은 외부 빈, #은 메소드의 파라미터
	@PreAuthorize("@boardSecurity.checkWriter(authentication.name, #fb_number)")
	public void modify(
			@RequestParam(name = "number") int fb_number,
			Model model) {
		
		BoardDto board = service.get(fb_number);
		model.addAttribute("board", board);
		
	}

		
	
	@PostMapping("modify")
	@PreAuthorize("@boardSecurity.checkWriter(authentication.name, #board.fb_number)")
	public String modify(BoardDto board, @RequestParam("files") MultipartFile[] addFiles,
			@RequestParam(name = "removeFiles", required = false) List<String> removeFiles) {
		service.update(board, addFiles, removeFiles);
		int num = board.getFb_number();
		
		return "redirect:/free/get?number=" + num;
	}

	@PostMapping("remove")
	@PreAuthorize("@boardSecurity.checkWriter(authentication.name, #fb_number)")
	public String remove(
			@RequestParam(name = "number") int fb_number) {
		service.remove(fb_number);
		
		return "redirect:/free/list";
	}
	
	@PutMapping("like")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> like(@RequestBody Map<String, String> req, Authentication auth){
		//System.out.println(req);
		String fb_number = req.get("fb_number");
		
		Map<String, Object> result = service.updateLike(fb_number, auth.getName());
														// 게시물번호, 로그인한 아이디
		return result;
	}
	
	//썸머노트 이미지 업로드
	  @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(BoardDto board, @RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String fb_filePath = "free/" + board.getFb_number(); //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  
	  String fb_image = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
	  
	  
	  System.out.println(fb_filePath);
	  
	  try {
			// putObjectRequest
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(fb_filePath)
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			// requestBody
			InputStream fileStream = multipartFile.getInputStream();
			software.amazon.awssdk.core.sync.RequestBody requestBody = software.amazon.awssdk.core.sync.RequestBody.fromInputStream(fileStream, multipartFile.getSize());
			
			// object(파일) 올리기
			s3Client.putObject(putObjectRequest, requestBody);
	
			//썸머노트 이미지 전달 위한 presigned URL 생성
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
			  GeneratePresignedUrlRequest generatePresignedUrlRequest = new GeneratePresignedUrlRequest(bucketName,fb_filePath)
					  .withMethod(HttpMethod.GET)
			  .withExpiration(expiration);
			  
			  String url =s3Client.generatePresignedUrl(generatePresignedUrlRequest).toString();
			  
			  System.out.println(url);
			 
			//url에 s3 bucket 파일 저장된 경로 전달해야됨... s3라 인증된 presignedUrl으로 전달


			jsonObject.put("url", url);
			jsonObject.put("fb_image", fb_image);
			jsonObject.put("responseCode", "success");
			
			
		} catch (Exception e) {  
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	  
	  return jsonObject;
	  }
	
	//파일 다운로드
	@GetMapping("download/{fb_number}/{filename}")
	@ResponseBody
	//서버에서 화면으로 응답을 하기 위해 HttpServletResponse 를 사용
	public void  downloadFile(@PathVariable("fb_number") int fb_number,
								@PathVariable String filename, HttpServletResponse response) throws Exception {
		
		//다운받을 파일 경로 지정
		/*
		 * File downloadFile = new File("academy/"+ab_number+"/"+filename);
		 */
		//파일을 byte 배열로 변환
		/* byte fileByte[] = FileUtils.readFileToByteArray(downloadFile); */
		
		
		String originalFileName = filename.substring(36);
		
		//getObjectRequest(파일 다운로드 관련 기능)
		GetObjectRequest getObjectRequest = GetObjectRequest.builder()
				.bucket(bucketName)
				.key("free/"+fb_number+"/"+originalFileName)
				.build();
		
		ResponseBytes<GetObjectResponse> obj = s3Client.getObjectAsBytes(getObjectRequest);
		
		System.out.println("obj : " + obj);
		
		byte[] fileByte = obj.asByteArray();
		
		//"application/octet-stream" 은 자바에서 사용하는 파일 다운로드 응답 형식으로, 어플리케이션 파일이 리턴된다고 설정
		response.setContentType("application/octet-stream");
		
		//파일 사이즈를 지정
        response.setContentLength(fileByte.length);
		response.setHeader("Content-Type", "application/octet-stream;");
		
		//다운로드시 파일 이름을 지정(UUID제거)
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(filename.substring(36),"UTF-8") +"\";");
		
		//"application/octet-stream"은 binary 데이터이기 때문에 binary로 인코딩
        response.setHeader("Content-Transfer-Encoding", "binary");
		
        //버퍼에 파일을 담아 스트림으로 출력
        response.getOutputStream().write(fileByte);
        //버퍼에 저장된 내용을 클라이언트로 전송하고 버퍼를 비운다.
        response.getOutputStream().flush();
        //출력 스트림을 종료
        response.getOutputStream().close();
        
	}
	
	

}
