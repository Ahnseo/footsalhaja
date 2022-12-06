package com.footsalhaja.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.service.admin.AdminService;
import com.footsalhaja.service.member.MemberService;
import com.footsalhaja.service.qna.QnAService;

@Controller
@RequestMapping("admin")
public class AdminController {

	@Autowired
	private QnAService qnaService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("allBookList")
	public void allBookList() {
		
	}
	
	@GetMapping("allQnAList")
	public void allQnAList(@RequestParam(name="page", defaultValue = "1") int page , QnAPageInfo qnaPageInfo ,Model model) {	
		List<QnADto> allQnAList= adminService.selectAllQnAList(page, qnaPageInfo);
		System.out.println(allQnAList);
		//아직 allQnAList.jsp 작업 못함 
		model.addAttribute("allQnAList", allQnAList);
		model.addAttribute("qnaPageInfo", qnaPageInfo);
	}
	
	@GetMapping("dashboard")
	public void dashboard() {
		
	}
	
	@GetMapping("memberList")
	public void list(Model model) {
		List <MemberDto> memberList = memberService.selectMemberList();
		model.addAttribute("memberList", memberList);
	}
	
	@GetMapping("stadiumManagement")
	public void stadiumManagement() {
		
	}
}
