package com.footsalhaja.controller.qna;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	private String qnaReply(@RequestBody QnAReplyDto qnaReply, Authentication authentication, Model model, HttpServletRequest request ) {
		//String loggedinId = authentication.getName();
		//System.out.println("ctrl loggedinId : " + loggedinId);
		//System.out.println("ctrl qnaReplyInfo.writer : " +qnaReply.getWriter());
		//System.out.println("ctrl qnaReplyInfo all : " + qnaReply);
		qnaService.insertQnAReply(qnaReply) ;
		
		// 답변 저장하면! -> QnABoard status '답변완료' 업데이트 하기. 
		
		// @ResponseBody redirect 방법 : request.getHeader() + jsp script .then(res=> res.text()).then(text=>location.href=text)
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		//System.out.println(referer);
		return referer; // 이전 페이지로 이동하기 위한 값 
	}
	@PostMapping("qnaAnswerModify")
	@ResponseBody
	public String updateQnAAnswer(@RequestBody QnAReplyDto modifiedAnswer, HttpServletRequest request ) {
		int answerId = modifiedAnswer.getQnaReplyId();
		String content = modifiedAnswer.getContent();
		qnaService.updateAnswerByAnswerId(answerId, content);
		
		String referer = request.getHeader("Referer");
		return referer;
	}
	@PutMapping("addToAnswer")
	@ResponseBody
	private String qnaReplyToAnswer(@RequestBody QnAReplyToAnswerDto qnaReplyToAnswer, Authentication authentication, Model model, HttpServletRequest request) {
		System.out.println(qnaReplyToAnswer);
		qnaService.insertQnAReplyToAnswer(qnaReplyToAnswer) ;
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		return referer; // 이전 페이지로 이동하기 위한 값 
	}
	
	@DeleteMapping("deleteQnAAnswer")
	@ResponseBody
	public String deleteAnswer(@RequestBody QnAReplyDto qnaReply, HttpServletRequest request) {
		//qnaReplyId, qnaId, UserId 값 잘 넘어옴! 이 값들로 삭제 기능
		//System.out.println("deleteAnswer:"+qnaReply);
		
		qnaService.deleteAnswerByAnswerId(qnaReply);
		
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		
		return referer; // 이전 페이지로 이동하기 위한 값 
	}
	@DeleteMapping("deleteQnAReply")
	@ResponseBody
	public String deleteQnAReply(@RequestBody int qnaReplyToAnswerId, HttpServletRequest request) {
		//qnaReplyId, qnaId, UserId 값 잘 넘어옴! 이 값들로 삭제 기능
		//System.out.println("deleteAnswer:"+qnaReply);
		System.out.println(qnaReplyToAnswerId);
		qnaService.deleteQnAReplyByReplyId(qnaReplyToAnswerId);
		
		String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
		
		return referer; // 이전 페이지로 이동하기 위한 값 
	}
	@PostMapping("modifyReply")
	@ResponseBody
	public void modifyReply(@RequestBody QnAReplyToAnswerDto reply) {
		qnaService.updateReplyById(reply.getQnaReplyToAnswerId(), reply.getContent());

	}

	@DeleteMapping("deleteQnA")
	@ResponseBody
	public String deleteQnA(@RequestBody int qna, String userId, HttpServletRequest request) {
		//qnaId, qnaReplyId 값 잘 넘어옴! 이 값들로 삭제 기능
		System.out.println("serv deleteQnA qnaId : " + qna);	
		//질문 삭제 
		qnaService.deleteQnA(qna);
		
		return "qnaMainBoard"; 
	}
	
	
	
	
	
}
