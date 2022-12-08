package com.footsalhaja.controller.academy;

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


@Controller
@RequestMapping("academy")
public class AcademyController {
	
	@Autowired
	private AcademyServiceImpl service;
	
	
	//list 목록
	@GetMapping("list")
	public void list(Criteria cri, Model model) {
	
		// request param
		// business logic

		String keyword = cri.getKeyword();
		cri.setKeyword("%"+cri.getKeyword()+"%");
		List<BoardDto> list = service.listBord(cri);
		
		System.out.println(list);
		
		// add attribute
		model.addAttribute("boardList", list);
		
		//전체 데이터의 수 구해서 페이지네이션
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDto(cri, total));
		// forward
		
		cri.setKeyword(keyword);
		
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
	
	

	  @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	  
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String ab_filePath = "C:\\Users\\lnh1017\\Desktop\\study\\project\\"; //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  
	  String ab_image = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
	  
	  File targetFile = new File(ab_filePath + ab_image);
	  
	  System.out.println(targetFile);
	  
	  try {
		  InputStream fileStream = multipartFile.getInputStream();
		  FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
		  jsonObject.put("url", "/summernoteImage/" + ab_image);
		  jsonObject.put("ab_image", ab_image);
		  jsonObject.put("responseCode", "success");
	  
	  } catch (IOException e) {
		  System.out.println(targetFile);
		  
		  FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
		  jsonObject.put("responseCode", "error"); e.printStackTrace();
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
		
		return "redirect:/academy/list";
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
		File downloadFile =  new File("C:\\Users\\lnh1017\\Desktop\\study\\project"+ab_number+"\\"+filename);
		
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
