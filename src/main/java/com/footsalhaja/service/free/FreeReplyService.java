package com.footsalhaja.service.free;

import java.util.List;

import com.footsalhaja.domain.free.FreeReplyDto;

public interface FreeReplyService {

	public int addReply(FreeReplyDto reply);

	public List<FreeReplyDto> listReplyByBoardId(int freeBoard_fb_number, String username);

	public int deleteById(int fb_replyNumber);

	public FreeReplyDto getById(int fb_replyNumber);

	public int modify(FreeReplyDto reply);


}
