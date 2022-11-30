package com.footsalhaja.controller.community.academy;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("academy")
public class AcademyBoardController {
	

	@GetMapping("list")
	public void list(){
		System.out.println("test");
	}
	
	

}
