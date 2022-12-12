package com.footsalhaja.mapper.main;

import java.util.List;

import com.footsalhaja.domain.main.ReplyDto;

public interface ReplyMapper {

	int insert(ReplyDto reply);

	List<ReplyDto> selectReplyByBookId(int bookId, String usename);

	int deleteById(int replyId);

	ReplyDto selectByReplyId(int replyId);

	int deleteByBookId(int bookId);

	//String selectNick(String userId);
}
