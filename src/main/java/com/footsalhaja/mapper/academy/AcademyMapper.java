package com.footsalhaja.mapper.academy;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;


public interface AcademyMapper {
	
	public int insert(BoardDto board);

	public BoardDto select(int ab_number, String member_userId);

	public int modify(BoardDto board);

	public int remove(int ab_number);
	
	public List<BoardDto> list();
	
	//페이지 네이션
	public List<BoardDto> getListWithPaging(Criteria cri, int offset, int records, String category);
	
	public int getTotalCount(Criteria cri, int ab_number);
	
	//좋아요
	public int getLike(String ab_number, String member_userId);

	public void deleteLike(String ab_number, String member_userId);

	public void insertLike(String ab_number, String member_userId);

	public int countLikeByab_number(String ab_number);
	
	//좋아요가 외래키로 참조되서 게시물 수정, 삭제에 쓸 default 메소드 select 
	default BoardDto select(int ab_number) {
		return select(ab_number, null);
	}
	//조회수
	public int updateViewCount(int ab_number);

	//파일
	public void insertFile(int ab_number, String ab_fileName, String ab_filePath, int ab_fileType);

	public void deleteFileByBoardId(int ab_number);

	public void deleteByBoardIdAndFileName(int ab_number, String originalFilename);

	public void deleteLikeByBoardId(int ab_number);
	
	
	
}
