package com.footsalhaja.controller.academy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.service.academy.AcademyServiceImpl;

@Controller
@RequestMapping("academy")
public class AcademyController {
	
	@Autowired
	private AcademyServiceImpl service;

	
	//list 목록
	@GetMapping("list")
	public void list(Model model) {
		// request param
		// business logic
		List<BoardDto> list = service.listBord();
		
		// add attribute
		model.addAttribute("boardList", list);
		// forward
	}
	
	//register 등록
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(BoardDto board) {
		service.insert(board);
		
		return "redirect:/academy/list";
	}
	
	//get 게시글
	@GetMapping("get")
	public void get (int ab_number, Model model) {
		BoardDto board = service.get(ab_number);
		
		System.out.println(board);
		
		model.addAttribute("board",board);
	}
	
}
