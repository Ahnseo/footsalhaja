package com.footsalhaja.controller.free;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	public String insert(BoardDto board, RedirectAttributes rttr) {
		service.insert(board);
		
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
	public String modify(BoardDto board, RedirectAttributes rttr) {
		int cnt = service.update(board);
		
		if (cnt == 1) {
			rttr.addFlashAttribute("message", "새 게시물이 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 게시물이 수정되지 않았습니다.");			
		}
		
		return "redirect:/free/list";
	}

	@PostMapping("remove")
	@PreAuthorize("@boardSecurity.checkWriter(authentication.name, #fb_number)")
	public String remove(
			@RequestParam(name = "number") int fb_number,
			RedirectAttributes rttr) {
		int cnt = service.remove(fb_number);
		
		if (cnt == 1) {
			rttr.addFlashAttribute("message", "새 게시물이 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 게시물이 삭제되지 않았습니다.");			
		}
		
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
	
	// 썸머노트 이미지 파일
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public HashMap<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		HashMap<String, String> jsonObject = new HashMap<>();
		  
		  
		String fb_filePath = "D:\\study\\lyh_image\\"; //저장될 외부 파일 경로 String
		String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
		  
		String fb_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
		  
		File targetFile = new File(fb_filePath + fb_fileName);
		  
		System.out.println(targetFile);
		  
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.put("url", "/summernoteImage/" + fb_fileName);
			jsonObject.put("fb_fileName", fb_fileName);
			jsonObject.put("responseCode", "success");
		  
		} catch (IOException e) {
			System.out.println(targetFile);
			  
			FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
			jsonObject.put("responseCode", "error"); e.printStackTrace();
		}
		  
		return jsonObject;
		  
	}
	
	

}
