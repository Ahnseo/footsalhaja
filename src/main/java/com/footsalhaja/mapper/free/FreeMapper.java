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

	
}
