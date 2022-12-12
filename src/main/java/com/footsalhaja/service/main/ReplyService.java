package com.footsalhaja.service.main;

import java.util.List;

import com.footsalhaja.domain.main.ReplyDto;

public interface ReplyService {
	
	public int addReply(ReplyDto reply);

	public List<ReplyDto> listReplyByBookId(int bookId, String username);

	public int removeById(int replyId);
	
	public ReplyDto getByReplyId(int replyId);
}
