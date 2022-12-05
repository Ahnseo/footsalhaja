package com.footsalhaja.controller.qna;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;


import com.footsalhaja.service.qna.QnAService;
import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;


@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired	

	private QnAService qnAService;
	
	//main
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard(Model model) {
		//FAQ data 가져오기
		List<FAQDto> FAQList = qnAService.selectFAQList();
		//System.out.println(FAQList);
		
		model.addAttribute("FAQList", FAQList);
		
	}
	
	// insert
	@GetMapping("insert")
	public void insertPageOpen(){
		
	}
	@PostMapping("insert")
	public String insertQnA(QnADto qnaBoard, String userId){
		
		qnAService.insertQnABoard(qnaBoard); //null : ServiceImpl 에서만 model 사용중이기 때문    

		return "redirect:/qna/myQnAList/" + userId; 
	}
	
	// MyQnAList @PathVariable 사용해보기 !! 성공
	@GetMapping("myQnAList/{userId}")
	public String myQnAList(Model model, @PathVariable String userId){
		
		List<QnADto> myQnAList = new ArrayList<>();		
		myQnAList = qnAService.myQnAList(userId);	
		//System.out.println(myQnAList);
		model.addAttribute("myQnAList", myQnAList);

		int myQnAListSize = myQnAList.size();
		model.addAttribute("myQnAListSize", myQnAListSize);
		
		return "/qna/myQnAList";
		
	}
	
	//get
	@GetMapping("myQnAGet")
	public void myQnAGet(){

	}

}