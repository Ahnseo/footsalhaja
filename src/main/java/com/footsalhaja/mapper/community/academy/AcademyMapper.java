package com.footsalhaja.mapper.community.academy;

import java.util.List;

import com.footsalhaja.domain.community.academy.BoardDto;


public interface AcademyMapper {
	
	int insert(BoardDto board);

	BoardDto select(int ab_number);

	int update(BoardDto board);

	int delete(int ab_number);
	
	//페이지 네이션(미정)
	List<BoardDto> list();
}
