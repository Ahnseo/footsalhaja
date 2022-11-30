package com.footsalhaja.service.free;

import java.util.List;

import com.footsalhaja.domain.free.BoardDto;

public interface FreeService {

	public int insert(BoardDto board);

	public List<BoardDto> listBoard();

	public BoardDto get(int fb_number);

	public int update(BoardDto board);

	public int remove(int fb_number);
	
}
