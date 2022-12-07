package com.footsalhaja.service.free;

import java.util.List;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.PageInfo;

public interface FreeService {

	public int insert(BoardDto board);

	public BoardDto get(int fb_number);

	public int update(BoardDto board);

	public int remove(int fb_number);
	
	// 페이지네이션
	public List<BoardDto> listBoard(int page, String type, String keyword2, PageInfo pageInfo);
}
