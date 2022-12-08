package com.footsalhaja.mapper.academy;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.Criteria;

public interface AcademyReplyMapper {

	int insert(AcademyReplyDto reply);

	List<AcademyReplyDto> selectReplyByBoardId(int ab_number, String username);

	int deleteById(int ab_replyNumber);
	
	int deleteByBoardId(int ab_number);

	AcademyReplyDto selectById(int ab_replyNumber);

	int modify(AcademyReplyDto reply);
	//페이지 네이션
	public List<AcademyReplyDto> getReplyListWithPaging(Criteria cri, int ab_number, String username, int offset, int records);
	//댓글 수
	public int getTotalReplyCount(int ab_number);


}
