package com.footsalhaja.mapper.academy;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;


public interface AcademyMapper {
	
	public int insert(BoardDto board);

	public BoardDto select(int ab_number);

	public int modify(BoardDto board);

	public int remove(int ab_number);
	
	public List<BoardDto> list();
	
	//페이지 네이션
	public List<BoardDto> getListWithPaging(Criteria cri, int offset, int records);
	
	public int getTotalCount(Criteria cri);

}
