package com.footsalhaja.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.admin.adminColChartDto;
import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.mapper.admin.AdminMapper;
import com.footsalhaja.mapper.qna.QnAMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private QnAMapper qnaMapper;
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public List<QnADto> selectAllQnAList(int page, QnAPageInfo qnaPageInfo, String keyword, String type) {
		// 페이지네이션 추가
		int records = 10; // 10 rows 씩 목록에 나타냅니다  
		int offset = (page - 1) * records; //page=2 : 11~20 rows ,  page=3 : 21~30 rows 나타냄 		
		int countAll = qnaMapper.countAllQnA(type, "%"+keyword+"%");
		int lastPageNumber = (countAll - 1) / records + 1;
		int leftPageNumber = (page - 1) / 10 * 10 + 1;
		int rightPageNumber = leftPageNumber + 9;
		rightPageNumber = Math.min(rightPageNumber, lastPageNumber);

		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 10 * 10 - 9;					
		int jumpNextPageNumber = (page - 1) / 10 * 10 + 11; 
							
		// 이전버튼 유무
		boolean hasPrevButton = page > 10;
		// 다음버튼 유무
		boolean hasNextButton = page <= ((lastPageNumber - 1) / 10 * 10);

		qnaPageInfo.setCurrentPageNumber(page);
		qnaPageInfo.setLeftPageNumber(leftPageNumber);
		qnaPageInfo.setRightPageNumber(rightPageNumber);
		qnaPageInfo.setLastPageNumber(lastPageNumber);	
		qnaPageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);	
		qnaPageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		qnaPageInfo.setHasPrevButton(hasPrevButton);	
		qnaPageInfo.setHasNextButton(hasNextButton);
				
		return qnaMapper.selectAllQnAList(offset, records, "%"+keyword+"%", type);
	}
	
	@Override
	public List<BookDto> selectBookedListAll(int page , QnAPageInfo qnaPageInfo ,String type ,String keyword) {
		// 페이지네이션 추가
			int records = 10; // 10 rows 씩 목록에 나타냅니다  
			int offset = (page - 1) * records; //page=2 : 11~20 rows ,  page=3 : 21~30 rows 나타냄 		
			int countAll = qnaMapper.countAllQnA(type, "%"+keyword+"%");
			int lastPageNumber = (countAll - 1) / records + 1;
			int leftPageNumber = (page - 1) / 10 * 10 + 1;
			int rightPageNumber = leftPageNumber + 9;
			rightPageNumber = Math.min(rightPageNumber, lastPageNumber);

			// 이전버튼 눌렀을 때 가는 페이지 번호
			int jumpPrevPageNumber = (page - 1) / 10 * 10 - 9;					
			int jumpNextPageNumber = (page - 1) / 10 * 10 + 11; 
								
			// 이전버튼 유무
			boolean hasPrevButton = page > 10;
			// 다음버튼 유무
			boolean hasNextButton = page <= ((lastPageNumber - 1) / 10 * 10);

			qnaPageInfo.setCurrentPageNumber(page);
			qnaPageInfo.setLeftPageNumber(leftPageNumber);
			qnaPageInfo.setRightPageNumber(rightPageNumber);
			qnaPageInfo.setLastPageNumber(lastPageNumber);	
			qnaPageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);	
			qnaPageInfo.setJumpNextPageNumber(jumpNextPageNumber);
			qnaPageInfo.setHasPrevButton(hasPrevButton);	
			qnaPageInfo.setHasNextButton(hasNextButton);
		
		int status = 0; //예약된 매칭만 리스트로 가져오기  -> allBookList.jsp 테이블로 보여주기 
		
		
		return adminMapper.selectBookedListAll(offset, records ,type ,"%"+keyword+"%", status);
	}
	
	@Override
	public List<QnADto> selectWatingQnAList() {
		String status = "답변대기";
		return adminMapper.selectWatingQnAList(status);
	}
	
	@Override
	public List<BookDto> selectBookedListLimit() {
		int status = 0; //예약됨 = 0값 으로 설정되어있음 
		return adminMapper.selectBookedListLimit(status);
	}
	@Override
	public int selectTodayVisitCount() {
		return adminMapper.selectTodayVisitCount();
	}
	@Override
	public int selectTodaybookedCount() {
		return adminMapper.selectTodaybookedCount();
	}
	@Override
	public int selectTodayWaitingQnACount() {
		String status = "답변대기";
		return adminMapper.selectTodayWaitingQnACount(status);
	}
	@Override
	public List<adminColChartDto> chartListByDate() {
		
		return adminMapper.chartListByDate();
	}

	
	
}
