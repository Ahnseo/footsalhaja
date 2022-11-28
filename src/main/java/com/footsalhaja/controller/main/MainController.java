package com.footsalhaja.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("main")
public class MainController {
	@GetMapping("get")
	public void get() {
		
	}
	
	@GetMapping("list")
	public void list() {
		
	}
	
	@GetMapping("modify")
	public void modify() {
		
	}
	
}
