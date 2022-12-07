package com.footsalhaja.mapper.free;

import java.util.List;

import com.footsalhaja.domain.free.FreeReplyDto;

public interface FreeReplyMapper {

	int insert(FreeReplyDto reply);

	List<FreeReplyDto> listReplyByBoardId(int freeBoard_fb_number, String username);

	int deleteById(int fb_replyNumber);

	FreeReplyDto getById(int fb_replyNumber);

	int update(FreeReplyDto reply);

	int deleteByBoardId(int fb_number);


}
