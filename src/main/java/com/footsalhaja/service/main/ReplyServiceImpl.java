package com.footsalhaja.service.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.mapper.main.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int addReply(ReplyDto reply) {
		return mapper.insert(reply);
		
	}
	@Override
	public List<ReplyDto> listReplyByBookId(int bookId, String username) {
		return mapper.selectReplyByBookId(bookId, username);
	}
	@Override
	public int removeById(int replyId) {
		return mapper.deleteById(replyId);
		
	}
	@Override
	public ReplyDto getByReplyId(int replyId) {
		return mapper.selectByReplyId(replyId);
	}

	

}

