package com.footsalhaja.service.community.academy;

import java.util.List;

import com.footsalhaja.domain.community.academy.BoardDto;

public interface AcademyService {

	//BoardDto는 community.academy.BoardDto 이므로 각자 Dto 파일 먼저 만들고 작성하기
	public void insert(BoardDto board);
	
	public BoardDto get(int ab_number);
	
	public int modify(BoardDto board);
	
	public int remove (int ab_number);
	
	//페이지네이션
	public List<BoardDto> listBaord();
}
