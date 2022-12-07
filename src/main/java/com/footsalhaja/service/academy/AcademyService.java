package com.footsalhaja.service.academy;

import java.util.List;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;

public interface AcademyService {

	public void insert(BoardDto board);
	
	public BoardDto get(int ab_number);
	
	public int modify(BoardDto board);
	
	public int remove (int ab_number);
	
	//페이지네이션 
	public List<BoardDto> listBord(Criteria cri);
	
	public int getTotal(Criteria cri);

	

}
