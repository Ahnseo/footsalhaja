package com.footsalhaja.service.academy;

import java.util.List;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.domain.academy.ReplyPageDto;

public interface AcademyReplyService {

	public int addReply(AcademyReplyDto reply);
	
	public List<AcademyReplyDto> listReplyByab_number(int ab_number, String username);
	
	public int removeById(int ab_replyNumber);

	public AcademyReplyDto getById(int ab_replyNumber);
	
	public int modify(AcademyReplyDto reply);
	
	//페이지네이션 (댓글 수 포함)
	public ReplyPageDto replyWithPaging(Criteria cri, int ab_number, String username);
	

}
