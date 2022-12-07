package com.footsalhaja.service.free;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.PageInfo;
import com.footsalhaja.mapper.free.FreeMapper;
import com.footsalhaja.mapper.free.FreeReplyMapper;

@Service
@Transactional
public class FreeServiceImpl implements FreeService{
	
	@Autowired
	private FreeMapper freeMapper;
	
	@Autowired
	private FreeReplyMapper replyMapper;
	
	
	@Override
	public int insert(BoardDto board) {
		return freeMapper.insert(board);
	}


	@Override
	public List<BoardDto> listBoard(int page, String type, String keyword, PageInfo pageInfo) {
		int records = 10; // 게시글 갯수
		int offset = (page - 1) * records; // 어디서부터
		
		int countAll = freeMapper.countAll(type, "%" + keyword + "%"); // 총 게시물 갯수
		int lastPage = (countAll - 1) / records + 1; // 마지막 페이지
		
		// 5페이지씩 보이게
		int leftPageNumber = (page - 1) / 5 * 5 + 1;
		int rightPageNumber = leftPageNumber + 4;
		rightPageNumber = Math.min(rightPageNumber, lastPage);
		
		// 이전 버튼 유무
		boolean hasPrevButton = page > 5;
		// 다음 버튼 유무
		boolean hasNextButton = page <= ((lastPage - 1) / 5 * 5);
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 5 * 5 - 4;
		// 다음버튼 눌렀을 때 가는 페이지 번호
		int jumpNextPageNumber = (page - 1) / 5 * 5 + 6; 
		
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);
		pageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		pageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		pageInfo.setCurrentPageNumber(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setLastPageNumber(lastPage);
		
		return freeMapper.list(offset, records, type,  "%" + keyword + "%");
	}
	 
	// 게시물 보기
	@Override
	public BoardDto get(int fb_number) {
		return freeMapper.select(fb_number);
	}
	 
	@Override
	public int update(BoardDto board) {
		return freeMapper.update(board);
	}
	
	
	// 게시물 지우기
	@Override
	public int remove(int fb_number) {
		// 게시물의 댓글 지우기
		replyMapper.deleteByBoardId(fb_number);
		
		// 게시물 지우기
		return freeMapper.delete(fb_number);
	}
	
	
	
}
