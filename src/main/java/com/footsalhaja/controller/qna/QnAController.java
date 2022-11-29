package com.footsalhaja.controller.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.service.qna.QnAServiceImpl;

@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired	
	private QnAServiceImpl qnAServiceImpl;
	
	//mainBoard
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard() {
		
	}
	
	// insert
	@GetMapping("insert")
	public void insertPageOpen(){
		
	}
	@PostMapping("insert")
	public String insertQnA(QnADto qnaBoard){
		
		qnAServiceImpl.insertQnADto(qnaBoard);
		
		return "redirect:/qna/listMyQnA";
	}
	
	// list
	@GetMapping("listMyQnA")
	public void listMyQnA(){
		
	}
	
	//get
	@GetMapping("getMyQnA")
	public void getMyQnA(){
		
	}

}