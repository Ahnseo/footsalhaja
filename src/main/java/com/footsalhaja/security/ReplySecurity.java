package com.footsalhaja.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.mapper.academy.AcademyReplyMapper;
import com.footsalhaja.mapper.free.FreeReplyMapper;

@Component // 빈으로 사용하기 위해
public class ReplySecurity {
	
	@Autowired
	private FreeReplyMapper freeMapper;
	
	@Autowired
	private AcademyReplyMapper academyMapper;
	
	// 프리보드 댓글 권한체크
	public boolean checkWriter(String userName, int fb_replyNumber) {
		FreeReplyDto reply = freeMapper.getById(fb_replyNumber);
		
		return reply.getMember_userId().equals(userName);
	}
	
	//아카데미 댓글 권한체크
	public boolean checkWriter2(String userName, int ab_replyNumber) {
		AcademyReplyDto academyReply = academyMapper.selectById(ab_replyNumber);
		return academyReply.getMember_userId().equals(userName);
	}
	
}
