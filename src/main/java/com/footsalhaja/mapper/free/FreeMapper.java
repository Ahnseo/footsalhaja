package com.footsalhaja.mapper.free;

import java.util.List;

import com.footsalhaja.domain.free.BoardDto;

public interface FreeMapper {

	int insert(BoardDto board);

	BoardDto select(int fb_number);

	int update(BoardDto board);

	int delete(int fb_number);
	
	List<BoardDto> list(int offset, int records, String type, String keyword);

	int countAll(String type, String keyword);

	int getLikeByBoardNumberAndUserId(String freeBoard_fb_number, String member_userId);

	int countLikeByBoardNumber(String fb_number);

	int deleteLike(String fb_number, String userId);

	int insertLike(String fb_number, String userId);

	
}
