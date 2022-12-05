package com.footsalhaja.controller.free;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		int cnt = service.insert(board);
		
		if (cnt == 1) {
			rttr.addFlashAttribute("message", "새 게시물이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 게시물이 등록되지 않았습니다.");			
		}
		
		return "redirect:/free/list";
	}
	
	@GetMapping("list")
	public void list(
			@RequestParam(name = "page", defaultValue = "1") int page, // 페이지
			@RequestParam(name = "t", defaultValue = "all") String type, // 검색범위(카테고리)
			@RequestParam(name = "q", defaultValue = "") String keyword, // 검색어
			PageInfo pageInfo,
			Model model) {
		
		List<BoardDto> list = service.listBoard(page, type, keyword, pageInfo);
		
		model.addAttribute("boardList", list);
	}


	@GetMapping("get")
	public void get(
			@RequestParam(name = "number") int fb_number,
			Model model) {
		BoardDto board = service.get(fb_number);
		
		model.addAttribute("board", board);
	}
	
	
	@GetMapping("modify")
	public void modify(
			@RequestParam(name = "number") int fb_number,
			Model model) {
		BoardDto board = service.get(fb_number);
		
		model.addAttribute("board", board);
	}
	
	@PostMapping("modify")
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

	
	

}
