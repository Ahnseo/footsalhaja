package com.footsalhaja.service.academy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.mapper.academy.AcademyMapper;

@Service
public class AcademyServiceImpl implements AcademyService{
	
	@Autowired
	private AcademyMapper mapper;

	
//테스트용으로 메소드 작성	
	@Override
	public void insert(BoardDto board) {
		// TODO Auto-generated method stub
		System.out.println("테스트용 등록 확인 게시글 번호" + board);
		
		mapper.insert(board);
	}
	
	@Override
	public List<BoardDto> listBord() {
		// TODO Auto-generated method stub
		return mapper.list();
	}
	
	@Override
	public BoardDto get(int ab_number) {
		// TODO Auto-generated method stub
		return mapper.select(ab_number);
	}
	
	@Override
	public int modify(BoardDto board) {
		// TODO Auto-generated method stub
		return mapper.modify(board);
	}

	@Override
	public int remove(int ab_number) {
		// TODO Auto-generated method stub
		return mapper.remove(ab_number);
	}
	
	
}
