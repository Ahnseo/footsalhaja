package com.footsalhaja.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.service.main.MainServiceImpl;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Autowired
	private MainServiceImpl service;
	
	@GetMapping("get")
	public void get(@RequestParam(name="id") int id,
			Model model) {
		service.get(id);
		
	}
	
	@GetMapping("list")
	public void list() {
		
	}
	
	@GetMapping("modify")
	public void modify() {
		
	}
	
}
