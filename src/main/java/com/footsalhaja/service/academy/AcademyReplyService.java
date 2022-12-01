package com.footsalhaja.service.academy;

import java.util.List;

import com.footsalhaja.domain.academy.AcademyReplyDto;

public interface AcademyReplyService {

	public int addReply(AcademyReplyDto reply);
	
	public List<AcademyReplyDto> listReplyByab_number(int ab_number);
}
