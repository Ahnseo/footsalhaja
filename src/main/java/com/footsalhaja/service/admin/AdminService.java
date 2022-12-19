package com.footsalhaja.service.admin;

import java.util.List;

import com.footsalhaja.domain.admin.adminColChartDto;
import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;

public interface AdminService {
	
	//관리자가 볼수있는 모든 질문정보 얻기 int records, int offset 페이지네이션 
	public List<QnADto> selectAllQnAList(int page, QnAPageInfo qnaPageInfo, String keyword, String type, String c, String s);
	
	//관리자가 볼수있는 처리되지않은 문의 정보들 가져오기 
	public List<QnADto> selectWatingQnAList();
	
	//관리자가 볼수있는 예약된 리스트 
	public List<BookDto> selectBookedListLimit();
	
	public List<BookDto> selectBookedListAll(int page , QnAPageInfo qnaPageInfo ,String type ,String keyword, String s, String l, String d1, String d2);

	public int selectTodayVisitCount();

	public int selectTodaybookedCount();
	
	public int selectTodayWaitingQnACount();

	public List<adminColChartDto> chartListByDate();


	
}
