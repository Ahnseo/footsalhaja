package com.footsalhaja.controller.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;
import com.footsalhaja.service.qna.QnAService;

@Controller
@RequestMapping("qnaReply")
public class QnAReplyController {

	@Autowired
	QnAService qnaService;
	
	@PutMapping("add")
	@ResponseBody
	private String qnaReply(@RequestBody QnAReplyDto qnaReply, Authentication authentication, Model model) {
		//String loggedinId = authentication.getName();
		//System.out.println("ctrl loggedinId : " + loggedinId);
		//System.out.println("ctrl qnaReplyInfo.writer : " +qnaReply.getWriter());
		//System.out.println("ctrl qnaReplyInfo all : " + qnaReply);
		qnaService.insertQnAReply(qnaReply) ;
		
		//redirect: 넣자 
		return "qna/myQnAGet?userId="+qnaReply.getUserId()+"&qnaId="+qnaReply.getQnaId();
	}
	
	@PutMapping("addToAnswer")
	@ResponseBody
	private String qnaReplyToAnswer(@RequestBody QnAReplyToAnswerDto qnaReplyToAnswer, Authentication authentication, Model model) {
		System.out.println(qnaReplyToAnswer);
		qnaService.insertQnAReplyToAnswer(qnaReplyToAnswer) ;
		
		return "qna/myQnAGet?userId="+qnaReplyToAnswer.getUserId()+"&qnaId="+qnaReplyToAnswer.getQnaId(); //myQnAGet 게시판으로 이동.
	}
	
	
	
	
	
	
}
