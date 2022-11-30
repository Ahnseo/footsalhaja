package com.footsalhaja.mapper.free;

import java.util.List;

import com.footsalhaja.domain.free.BoardDto;

public interface FreeMapper {

	int insert(BoardDto board);

	List<BoardDto> list();

	BoardDto select(int fb_number);

	int update(BoardDto board);

	int delete(int fb_number);

	
}
