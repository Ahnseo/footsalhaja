package com.footsalhaja.controller.qna;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

<<<<<<< Updated upstream
import com.footsalhaja.service.qna.QnAService;
=======

import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.service.qna.QnAServiceImpl;
>>>>>>> Stashed changes

@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired	
	private QnAService qnaService;
	
	//main
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard() {
		qnAServiceImpl.selectQnABoardAll();
	}
	
	// insert
	@GetMapping("insert")
	public void insertPageOpen(){
		
	}
	@PostMapping("insert")
<<<<<<< Updated upstream
	public String insertQnA(){
=======
	public String insertQnA(QnADto qnaBoard){
		
		int cnt = qnAServiceImpl.insertQnABoard(qnaBoard, null); //null : ServiceImpl 에서만 model 사용중이기 때문    
>>>>>>> Stashed changes
		
		return "redirect:/qna/myQnAList"; 
	}
	
	// MyQnAList
	@GetMapping("myQnAList")
	public void myQnAList(String userId, Model model){
		
		List<QnADto> myQnAList = new ArrayList<>();
		myQnAList = qnAServiceImpl.selectMyQnAListByUserId(userId);
		System.out.println(myQnAList);
		model.addAttribute("myQnAList", myQnAList);
		
	}
	
	//get
	@GetMapping("myQnAGet")
	public void myQnAGet(){
		
	}

}