package com.footsalhaja.controller.free;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.PageInfo;
import com.footsalhaja.service.free.FreeService;

@Controller
@RequestMapping("free")
public class FreeController {
	
	@Autowired
	private FreeService service;
	
	
	@GetMapping("insert")
	public void insert() {
		
	}
	
	@PostMapping("insert")
	public String insert(BoardDto board, MultipartFile[] files,
			RedirectAttributes rttr) {
		
		System.out.println(files);
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
		System.out.println("수정에서 넘어온값"+removeFiles);
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
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String fb_filePath = "D:\\study\\project\\footsalhaja\\sn_img\\"; //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  
	  String fb_image = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
	  
	  File targetFile = new File(fb_filePath + fb_image);
	  
	  System.out.println(targetFile);
	  
	  try {
		  InputStream fileStream = multipartFile.getInputStream();
		  FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
		  jsonObject.put("url", "/summernoteImage/" + fb_image);
		  jsonObject.put("fb_image", fb_image);
		  jsonObject.put("responseCode", "success");
	  
	  } catch (IOException e) {
		  System.out.println(targetFile);
		  
		  FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
		  jsonObject.put("responseCode", "error"); e.printStackTrace();
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
		File downloadFile =  new File("D:\\study\\project\\project"+fb_number+"\\"+filename);
		
		//파일을 byte 배열로 변환
		byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);
		
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
