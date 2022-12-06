package com.footsalhaja.service.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.mapper.main.ReplyMapper;

@Service
public class ReplyServiceImpl {
	
	@Autowired
	private ReplyMapper mapper;
	
	public int addReply(ReplyDto reply) {
		return mapper.insert(reply);
		
	}

	public List<ReplyDto> listReplyByBookId(int bookId) {
		return mapper.selectReplyByBookId(bookId);
	}

	public int removeById(int replyId) {
		return mapper.deleteById(replyId);
		
	}
}
