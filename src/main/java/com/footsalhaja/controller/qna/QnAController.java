package com.footsalhaja.controller.qna;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;


import com.footsalhaja.service.qna.QnAService;
import com.footsalhaja.domain.qna.QnADto;


@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired	

	private QnAService qnAService;
	
	//main
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard() {
		
	}
	
	// insert
	@GetMapping("insert")
	public void insertPageOpen(){
		
	}
	@PostMapping("insert")
	public String insertQnA(QnADto qnaBoard){
		

		qnAService.insertQnABoard(qnaBoard); //null : ServiceImpl 에서만 model 사용중이기 때문    

		return "redirect:/qna/myQnAList"; 
	}
	
	// MyQnAList
	@GetMapping("myQnAList")
	public void myQnAList(Model model){
		
		List<QnADto> myQnAList = new ArrayList<>();
		
		myQnAList = qnAService.list();
		
		System.out.println(myQnAList);
		model.addAttribute("myQnAList", myQnAList);


	}
	
	//get

	@GetMapping("myQnAGet")
	public void myQnAGet(){

	}

}