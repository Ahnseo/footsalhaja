package com.footsalhaja.service.free;

import java.util.List;
import java.util.Map;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.domain.free.PageInfo;

public interface FreeService {

	public int insert(BoardDto board);

	public BoardDto get(int fb_number, String member_userId);

	public BoardDto get(int fb_number);

	public int update(BoardDto board);

	public int remove(int fb_number);
	
	// 페이지네이션
	public List<BoardDto> listBoard(int page, String type, String keyword2, PageInfo pageInfo);

	public Map<String, Object> updateLike(String fb_number, String member_userId);

	// 조회수
	public int updateViewCount(int fb_number);
	
}
