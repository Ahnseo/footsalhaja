package com.footsalhaja.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.member.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("login")
	public void login() {
		// 이대로 void forward 사용.  
	}
	
	@GetMapping("insert")
	public void registerGetMapping(){
		//register.jsp  페이지 이동하기 위한 메소드 
	}
	@PostMapping("insert")
	public String registerPostMapping(MemberDto member){
		//회원가입 
		int cnt = memberService.insertMember(member);
		
		
		return "redirect:/main/list"; // 등록하고 -> /main/list.jsp 로 이동  
	}
	
}
