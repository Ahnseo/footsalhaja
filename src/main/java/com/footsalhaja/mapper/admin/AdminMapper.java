package com.footsalhaja.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.qna.QnADto;

@Mapper
public interface AdminMapper {

	List<QnADto> selectWatingQnAList(String status);

	List<BookDto> selectBookedListLimit(int status);
	
	List<BookDto> selectBookedListAll(int status);

	int insertVisitCount();

	int selectTodayVisitCount();

	int selectTodaybookedCount();
	
	int selectTodayWaitingQnACount(String status);

	
	
}
