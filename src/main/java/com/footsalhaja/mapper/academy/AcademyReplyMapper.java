package com.footsalhaja.mapper.academy;

import java.util.List;

import com.footsalhaja.domain.academy.AcademyReplyDto;

public interface AcademyReplyMapper {

	int insert(AcademyReplyDto reply);

	List<AcademyReplyDto> selectReplyByBoardId(int ab_number);

	int deleteById(int ab_replyNumber);

}
