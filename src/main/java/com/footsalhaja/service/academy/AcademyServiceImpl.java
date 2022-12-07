package com.footsalhaja.service.academy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.mapper.academy.AcademyMapper;
import com.footsalhaja.mapper.academy.AcademyReplyMapper;

@Service
public class AcademyServiceImpl implements AcademyService{
	
	@Autowired
	private AcademyMapper mapper;
	
	@Autowired
	private AcademyReplyMapper replyMapper;

	
	@Override
	public void insert(BoardDto board) {

		mapper.insert(board);
	}
	
	@Override
	public List<BoardDto> listBord(Criteria cri) {
		System.out.println("get List with Criteria: " +cri);
		
		int offset = (cri.getPageNum() -1) * cri.getAmount();
		int records = cri.getAmount();
		System.out.println(cri.getType());
		
		/* cri.setKeyword("%"+cri.getKeyword()+"%"); */
		
		return mapper.getListWithPaging(cri, offset,records);
	}
	
	@Override
	public BoardDto get(int ab_number, String member_userId) {
		// TODO Auto-generated method stub
		return mapper.select(ab_number, member_userId);
	}
	
	@Override
	public int modify(BoardDto board) {
		// TODO Auto-generated method stub
		return mapper.modify(board);
	}
	
	@Transactional
	@Override
	public int remove(int ab_number) {
		replyMapper.deleteByBoardId(ab_number);
		return mapper.remove(ab_number);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri, 123);
	}
	
	@Override
	public Map<String, Object> updateLike(String ab_number, String member_userId) {
		Map<String, Object> map = new HashMap<>();
		
		int cnt = mapper.getLike(ab_number, member_userId);
		if (cnt == 1) {
			// ab_number와 member_userId으로 좋아요 테이블 검색해서 있으면?
			// 삭제
			mapper.deleteLike(ab_number, member_userId);
			map.put("current", "not liked");
			
		} else {
			// 없으면?
			// insert
			mapper.insertLike(ab_number, member_userId);
			map.put("current", "liked");
		}

		int countAll = mapper.countLikeByab_number(ab_number);
		// 현재 몇개인지
		map.put("count", countAll);
		
		return map;
	}
	
	@Override
	public BoardDto get(int ab_number) {
		return get(ab_number, null);
	}
	
	@Override
	public int updateViewCount(int ab_number) {
		return mapper.updateViewCount(ab_number);
	}
	
}
