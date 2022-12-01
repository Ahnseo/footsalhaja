package com.footsalhaja.service.academy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.mapper.academy.AcademyReplyMapper;

@Service
public class AcademyReplyServiceImpl implements AcademyReplyService{
	
	@Autowired
	private AcademyReplyMapper mapper;

	@Override
	public int addReply(AcademyReplyDto reply) {
		return mapper.insert(reply);
	}
	
	@Override
	public List<AcademyReplyDto> listReplyByab_number(int ab_number) {
		return mapper.selectReplyByBoardId(ab_number);
	}
	
	@Override
	public int removeById(int ab_replyNumber) {
		return mapper.deleteById(ab_replyNumber);
	}
	
	@Override
	public AcademyReplyDto getById(int ab_replyNumber) {
		return mapper.selectById(ab_replyNumber);
	}
	
	@Override
	public int modify(AcademyReplyDto reply) {
		return mapper.modify(reply);
	}
}
