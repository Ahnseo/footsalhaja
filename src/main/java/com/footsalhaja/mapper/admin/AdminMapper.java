package com.footsalhaja.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.admin.adminColChartDto;
import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;

@Mapper
public interface AdminMapper {

	List<QnADto> selectWatingQnAList(String status);

	List<BookDto> selectBookedListLimit(int status);
	
	List<BookDto> selectBookedListAll(int offset, int records ,String type ,String keyword, int status);

	int insertVisitCount();

	int selectTodayVisitCount();

	int selectTodaybookedCount();
	
	int selectTodayWaitingQnACount(String status);

	List<adminColChartDto> chartListByDate();



	
	
}
