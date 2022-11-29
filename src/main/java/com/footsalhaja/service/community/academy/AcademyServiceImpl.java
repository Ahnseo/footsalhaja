package com.footsalhaja.service.community.academy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.community.academy.BoardDto;
import com.footsalhaja.mapper.community.academy.AcademyMapper;

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
//--------------------이 밑으로 아직 메소드 제대로 작성하지 않음(테스트도 X)--------------------------------
	@Override
	public BoardDto get(int ab_number) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int modify(BoardDto board) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int remove(int ab_number) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public List<BoardDto> listBaord() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
