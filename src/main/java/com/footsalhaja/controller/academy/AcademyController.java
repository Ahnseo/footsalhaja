package com.footsalhaja.controller.academy;

import java.io.File;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import com.footsalhaja.service.academy.AcademyServiceImpl;

import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Object;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.PresignedPutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.model.PutObjectPresignRequest;


import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.auth.profile.ProfilesConfigFile;

@Controller
@RequestMapping("academy")
public class AcademyController {
	
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
	
	//list 목록
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
		
		//전체 데이터의 수 구해서 페이지네이션
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDto(cri, total));
		// forward
		
		cri.setKeyword(keyword);
		
		// 좋아요 순위
		List<BoardDto> rank = service.likeRank(board); 
		model.addAttribute("likeRank", rank);
		
	}
	
	//register 등록
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(BoardDto board, MultipartFile[] files,
			RedirectAttributes rttr) {
		
		// request param 수집/가공
		
		// business logic
		service.insertFile(board, files);
		
		/* service.insert(board); */
		
				
		return "redirect:/academy/list";
	}
	
	
	//썸머노트 이미지 업로드
	  @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	  
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(BoardDto board,@RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String ab_filePath = "academy/" + board.getAb_number(); //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  
	  String ab_image = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
	  
	  File targetFile = new File(ab_filePath + ab_image);
	  
	  System.out.println("targetFile: "+targetFile);
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
			
			// object(파일) 올리기
			s3Client.putObject(putObjectRequest, requestBody);
			
			//GeneratePresignedUrl
			/*
			 * PutObjectPresignRequest presignRequest = PutObjectPresignRequest.builder()
			 * .signatureDuration(Duration.ofMinutes(10))
			 * .putObjectRequest(putObjectRequest) .build();
			 * 
			 * S3Presigner presigner = S3Presigner.builder() .region(Region.AP_NORTHEAST_2)
			 * .credentialsProvider(awsCredentialsProvider) .build();
			 * 
			 * PresignedPutObjectRequest presignedRequest =
			 * presigner.presignPutObject(presignRequest); String myURL =
			 * presignedRequest.url().toString();
			 * 
			 * System.out.println(myURL);
			 */
	
			/*
			 * Regions clientRegion = Regions.AP_NORTHEAST_2;
			 * 
			 * AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
			 * .withRegion(clientRegion) //credentials를 어떻게 넣어줘야 하나 .withCredentials(new
			 * ProfileCredentialsProvider()) .build();
			 * 
			 * 
			 * // Set the presigned URL to expire after one hour. java.util.Date expiration
			 * = new java.util.Date(); long expTimeMillis = Instant.now().toEpochMilli();
			 * expTimeMillis += 1000 * 60 * 60; expiration.setTime(expTimeMillis);
			 * 
			 * // Generate the presigned URL.
			 * System.out.println("Generating pre-signed URL."); GeneratePresignedUrlRequest
			 * generatePresignedUrlRequest = new GeneratePresignedUrlRequest(bucketName,
			 * ab_filePath + ab_image) .withMethod(HttpMethod.GET)
			 * .withExpiration(expiration);
			 * 
			 * String url =
			 * s3Client.generatePresignedUrl(generatePresignedUrlRequest).toString();
			 * 
			 * System.out.println(url);
			 */
            
			
			String presignedUrl = "https://study-2022-08-02-lnh-2023-02-09.s3.ap-northeast-2.amazonaws.com/academy/0?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAcaDmFwLW5vcnRoZWFzdC0yIkYwRAIgX%2BzIprBPqLVCUiK5USnBomkXMj04bfO4juN2J9%2FJJdMCIFA04SX7%2Fmx2ML4FR07TEeD1VuTYXQJUcNn7o0NH8xHWKugCCEAQABoMMjA4NDAzMzMwNzQ2Igw%2BN8tsWQrBOc1Gth8qxQIzWpkNxW8rIBUlt%2BYWikJOzVBG%2BzbwCMuO3y4YCyd3yaQq%2Bu%2B3Ck%2BocUBWwp5k58hZfhvg2xRYb%2BJyjpWzOw4jN5lRaa%2F52n0EGkySfW0oYjtQ%2F%2BfV2UDbONLuzCUVNwYjDjMuypSdToMvDN7vcoiBIQJAWyjutLy1iqtV81UL3D9f1%2Bz%2F0knfs3OkbL1gMD9vu6R9EjWN5bCItkhxWNNT2aK8U7eG9oh4UXSa6%2F0HGa2vgbuzHbTSpVPcNGBw4oJUI202pdkdOiKvq%2FzHW5imft4P9dp%2BzQw%2BNcDzAgdb9%2F%2BniThpB0Er%2BXhKYkXDXbT6TlCiNf2dGxTUn4%2FQ4bZQLID5QZZScG6%2BltNGVXJ7iI0i4nhRvKc0VLiFfUE5oPlNkb9MwiDCLq9D%2FteyoUpM0t6WR47OoFxxFP9lC%2B6qmWkYgsVeMOT6%2BpwGOrQCWxjktfi6I1uejj3rgdmHKx8NAA%2FoUYEu1fNCbTPEegMM5Iw%2FmcOXGLaDpzu9V6u8Nf%2B2GXsdm6z11ul2yetRzZhBx7Zk7pND8m3dIygKxUjuO7T3PS0ujBRYfGlOVuF882KZmaxkOnvKy6uezuU9MztvnillIpbDtGg8SO%2B7HtC1FlpUZ1Frq3Imkqr68v8AiCMevvswgRWBCmF4BrtNzK6o28HXVujUjUIZ3T7OoXe8JcdcRT745YUfk8Y0BSVcjUizuXLjBjO1Gq%2BsGL7pquegpGIm3YghYEexYImQhzU3%2BVCrSkPJFH3f%2Bd0NNOZmr5fI5Qp7txKAxXVcZ%2BZi33wQuekWpvt1tssBC7kquuQb06QJHWcyXM1mM5CbfXjFKFVYieTGK7LEUGM5pT7qglK5LzY%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221218T074340Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIATBBOOO25POLJT2S3%2F20221218%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=ce7ca700c9cecc3e76ef93ae76def9180c9d2a74217ab2999c55433ae2c8e000";
			
			String url =presignedUrl+ab_image;
			
			System.out.println();
			//url에 s3 bucket 파일 저장된 경로 전달해야됨... s3라 인증된 presignedUrl으로 전달했는데도 403에러 뜸...왜그럴까?
			jsonObject.put("url", url);
			jsonObject.put("ab_image", ab_image);
			jsonObject.put("responseCode", "success");
			
			
		} catch (Exception e) {  
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	 
	  
	  return jsonObject;
	  }
	  

	
	//get 게시글
	@GetMapping("get")
	public void get (@RequestParam("ab_number") int ab_number, Model model, @ModelAttribute("cri") Criteria cri, Authentication authentication) {
		String member_userId = null;
		
		if (authentication != null) {
			member_userId = authentication.getName();
		}
		
		service.updateViewCount(ab_number);
		BoardDto board = service.get(ab_number, member_userId);
		
		model.addAttribute("board",board);
	
		
	}
	
	//modify 게시글
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
	
	//remove 게시글
	@PreAuthorize("@boardSecurity.checkWriter2(authentication.name, #ab_number)")
	@PostMapping("remove") 
	public String remove(int ab_number) {
		service.remove(ab_number);
		
		return "redirect:/academy/list";
	}
	
	//좋아요 입력
	@PutMapping("like")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object> like(@RequestBody Map<String, String> req,
			Authentication authentication) {
		
		Map<String, Object> result = service.updateLike(req.get("ab_number"), authentication.getName());
		
		return result;
	}
	
	//파일 다운로드
	@GetMapping("download/{ab_number}/{filename}")
	@ResponseBody
	//서버에서 화면으로 응답을 하기 위해 HttpServletResponse 를 사용
	public void  downloadFile(@PathVariable("ab_number") int ab_number,
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
				.key("academy/"+ab_number+"/"+originalFileName)
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
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName,"UTF-8") +"\";");
		
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
