package com.footsalhaja.controller.free;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("free")
public class FreeController {
	
	@GetMapping("register")
	public void register() {
		
	}
}
