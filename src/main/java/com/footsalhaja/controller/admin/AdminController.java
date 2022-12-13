package com.footsalhaja.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.domain.main.BookDto;
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
	
	
	@GetMapping("dashboard")
	public void dashboard(Model model) {
		
		//날짜별 최신순으로 문의 리스트 가져오기 
		List <QnADto> waitingQnAList = adminService.selectWatingQnAList();
		model.addAttribute("waitingQnAList", waitingQnAList);
		
		//예약된 매치리스트 >= 오늘 포함, 다음 날짜들 까지 . (지나간 날은 제외 )
		List<BookDto> bookedList = adminService.selectBookedListLimit();
		//System.out.println(bookedList);
		model.addAttribute("bookedList", bookedList);
		
		
		//오늘의 방문자수 
		int todayVisitCount = adminService.selectTodayVisitCount();
		model.addAttribute("todayVisitCount", todayVisitCount);
		//오늘의 예약건수 
		int todaybookedCount = adminService.selectTodaybookedCount();
		model.addAttribute("todaybookedCount", todaybookedCount);
		//오늘의 문의건수 
		int todayWaitingQnACount = adminService.selectTodayWaitingQnACount();
		model.addAttribute("todayWaitingQnACount", todayWaitingQnACount);
	}
	
	@GetMapping("admin")
    public String getAdmin() {
        return "admin/admin";
    }
	
	@GetMapping("allBookList")
	public void allBookList(Model model) {
		List<BookDto> allBookedList = adminService.selectBookedListAll();
		model.addAttribute("allBookedList", allBookedList);
		
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
