package com.footsalhaja.controller.main;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.main.MainServiceImpl;
import com.footsalhaja.service.member.MemberServiceImpl;

@Controller
@RequestMapping("main")
public class MainController {
	
	@Autowired
	private MainServiceImpl service;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@GetMapping("get")
	public void get(@RequestParam(name="bookId") int bookId,
			Model model
			/*Authentication authentication*/) {
		
			/*
			 * String nickName = null;
			 * 
			 * if (authentication != null) { nickName = authentication.getName(); }
			 */
		
		//System.out.println(bookId);
		MainDto main = service.get(bookId);
		
		model.addAttribute("main", main);
		model.addAttribute("lat", main.getLat());
		model.addAttribute("lng", main.getLng());
	}
	
	@GetMapping("insert")
	public void insert(@RequestParam(name="userId") String userId,
			Model model) {
		MemberDto member = memberService.selectMemberInfoByUserId(userId);
		model.addAttribute("member", member);
		
		
	}
	
	@PostMapping("insert")
	public String insert(MainDto book, //
						RedirectAttributes rttr) {
		System.out.println("book1 : " +book);
		int cnt = service.insert(book);
		
		if (cnt == 1) {
			rttr.addFlashAttribute("message", "새 예약글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "예약글이 등록되지 않았습니다.");
		}
		
		return "redirect:/main/list";
	}
	
	
	  @GetMapping("list")
	  public void list(Model model, @RequestParam(name="datepickerSday", required = false)Date datepickerSday,
			  						@RequestParam(name="datepickerEday", required = false)Date datepickerEday) {
	  
		  List<BookDto> list = service.listBook(datepickerSday, datepickerEday);
		  model.addAttribute("bookList", list); 
		  
		  // main/list 들어오면,  Visit테이블 방문자수 +1 씩 증가  by asj
		  service.insertVisitCount();
		  
	}
	 
	@PreAuthorize("@mainSecurity.checkWriter(authentication.name,#bookId)")
	@GetMapping("modify")
	public void modify(int bookId, Model model) {
		MainDto main = service.get(bookId);		
		model.addAttribute("main", main);

	}

	@PreAuthorize("@mainSecurity.checkWriter(authentication.name,#main.bookId)")
	 @PostMapping("modify") 
	 public String modify(MainDto main) {
		 service.update(main);
	 
	 	return "redirect:/main/list";
	 
	 
	}

	 @PreAuthorize("@mainSecurity.checkWriter(authentication.name,#bookId)")
	 @PostMapping("remove")
	 public String remove(int bookId) {
		 service.remove(bookId);
		 
		 return "redirect:/main/list";
	 }
	 
	
}
