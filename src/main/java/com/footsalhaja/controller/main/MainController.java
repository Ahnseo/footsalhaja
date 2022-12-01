package com.footsalhaja.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.service.main.MainServiceImpl;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Autowired
	private MainServiceImpl service;
	
	@GetMapping("get")
	public void get(@RequestParam(name="bookId") int bookId,
			Model model) {

		//System.out.println(bookId);
		MainDto main = service.get(bookId);
		
		model.addAttribute("main", main);

	}
	
	@GetMapping("insert")
	public void insert() {
		
	}
	
	@PostMapping("insert")
	public String insert(MainDto mainBoard,
						RedirectAttributes rttr) {
		
		int cnt = service.insert(mainBoard);
		
		if (cnt == 1) {
			rttr.addFlashAttribute("message", "새 예약글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "예약글이 등록되지 않았습니다.");
		}
		
		return "redirect:/main/list";
	}
	
	@GetMapping("list")
	public void list() {
		
	}
	
	@GetMapping("modify")
	public void modify() {
		
	}
	

	@GetMapping("address") 
	public void address() {
		System.out.println("카카오 API 테스트");
	

	}
	
}
