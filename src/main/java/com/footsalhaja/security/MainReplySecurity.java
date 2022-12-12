package com.footsalhaja.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.mapper.main.ReplyMapper;

@Component
public class MainReplySecurity {
	
	@Autowired
	private ReplyMapper replyMapper;
	
	//메인 게시물 댓글 권한 체크
	public boolean checkWriter(String username, int replyId) {
		ReplyDto reply = replyMapper.selectByReplyId(replyId);
		
		return reply.getMember_userId().equals(username);
	}
	
	
	
}
