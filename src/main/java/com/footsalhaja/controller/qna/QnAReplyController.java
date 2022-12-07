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
import com.footsalhaja.service.qna.QnAService;

@Controller
@RequestMapping("qnaReply")
public class QnAReplyController {

	@Autowired
	QnAService qnaService;
	
	@PutMapping("add")
	@ResponseBody
	private String qnaReply(@RequestBody QnAReplyDto qnaReply, Authentication authentication, Model model) {
		
		System.out.println("qnaReply@:"+ qnaReply.getUserId());
		
		String loggedinId = authentication.getName();
		
		qnaService.insertQnAReply(qnaReply, loggedinId) ;
		
		return "qna/myQnAGet?userId="+qnaReply.getUserId()+"&qnaId="+qnaReply.getQnaId();
	}
}
