package com.footsalhaja.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.member.MemberPageInfo;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.service.admin.AdminService;
import com.footsalhaja.service.member.MemberService;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("allBookList")
	public void allBookList() {
		
	}
	
	@GetMapping("allQnAList")
	public void allQnAList(@RequestParam(name="page", defaultValue = "1") int page ,
							QnAPageInfo qnaPageInfo,
							Model model,
							@RequestParam(name="q") String keyword,
							@RequestParam(name="t") String type
							) {	
		List<QnADto> allQnAList= adminService.selectAllQnAList(page, qnaPageInfo, keyword, type);
		model.addAttribute("allQnAList", allQnAList);
		model.addAttribute("qnaPageInfo", qnaPageInfo);
		
	}
	
	@GetMapping("dashboard")
	public void dashboard() {
		
	}
	
	@GetMapping("allMemberList")
	public void list(@RequestParam(name="page", defaultValue = "1") int page,
					 MemberPageInfo memberPageInfo, 
					 @RequestParam(name="q") String keyword,
					 @RequestParam(name="t") String type,
					 Model model
					 ) {
		List <MemberDto> allMemberList = memberService.selectMemberList(page, memberPageInfo, keyword, type);
		model.addAttribute("allMemberList", allMemberList);
		model.addAttribute("memberPageInfo", memberPageInfo);
		
	}
	
	@GetMapping("stadiumManagement")
	public void stadiumManagement() {
		
	}
}
