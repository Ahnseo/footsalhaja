package com.footsalhaja.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.mapper.free.FreeReplyMapper;

@Component // 빈으로 사용하기 위해
public class ReplySecurity {
	
	@Autowired
	private FreeReplyMapper freeMapper;
	
	
	// 프리보드 댓글 권한체크
	public boolean checkWriter(String userName, int fb_replyNumber) {
		FreeReplyDto reply = freeMapper.getById(fb_replyNumber);
		
		return reply.getMember_userId().equals(userName);
	}
	
	
}
