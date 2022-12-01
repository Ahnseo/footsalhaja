package com.footsalhaja.service.academy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.mapper.academy.AcademyMapper;

@Service
public class AcademyServiceImpl implements AcademyService{
	
	@Autowired
	private AcademyMapper mapper;

	
	@Override
	public void insert(BoardDto board) {
		// TODO Auto-generated method stub
		System.out.println("테스트용 등록 확인 게시글 번호" + board);
		
		mapper.insert(board);
	}
	
	@Override
	public List<BoardDto> listBord(Criteria cri) {
		System.out.println("get List with Criteria: " +cri);
		
		int offset = (cri.getPageNum() -1) * cri.getAmount();
		int records = cri.getAmount();
		
		return mapper.getListWithPaging(cri, offset,records);
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
	
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}
	
	
}
