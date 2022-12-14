package com.footsalhaja.service.academy;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;

public interface AcademyService {

	public void insert(BoardDto board);
	
	public BoardDto get(int ab_number, String member_userId);
	
	public int modify(BoardDto board, MultipartFile[] addFiles, List<String> removeFiles);
	
	public int remove (int ab_number);
	
	//페이지네이션 
	public List<BoardDto> listBord(Criteria cri, String category);
	
	public int getTotal(Criteria cri);
	
	public Map<String, Object> updateLike(String ab_number, String member_userId); 
	
	//게시물 수정&삭제 default 메소드 get
	public BoardDto get(int ab_number);
	
	//게시물 조회수
	int updateViewCount(int ab_number);
	
	//파일 등록
	public int insertFile(BoardDto board, MultipartFile[] files);
	
	// 좋아요 순위
	public List<BoardDto> likeRank(BoardDto board);
	
	
}
