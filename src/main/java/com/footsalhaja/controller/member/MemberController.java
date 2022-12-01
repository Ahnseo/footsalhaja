package com.footsalhaja.controller.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	@GetMapping("list")
	public void list(Model model) {
		List <MemberDto> memberList = memberService.selectMemberList();
		//System.out.println(memberList);
		model.addAttribute("memberList", memberList);
	}
	
	@GetMapping({"get", "modify"})
	public void getAndModify(@RequestParam(name="userId") String userId, Model model){
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		System.out.println(userId);
		MemberDto memberInfoByUserId = memberService.selectMemberInfoByUserId(userId);
		System.out.println(memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
		
	}
	
	
}
