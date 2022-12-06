package com.footsalhaja.service.qna;

import java.util.List;
import java.util.Map;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;

public interface QnAService {

	public int insertQnABoard(QnADto qnaBoard);
	
	public List<QnADto> myQnAList(String userId, int page, QnAPageInfo qnaPageInfo);
	
	public QnADto selectMyQnAListByUserId(String userId);

	public List<FAQDto> selectFAQList();

	public QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId);
	
	//관리자가 볼수있는 모든 질문정보 얻기 int records, int offset 페이지네이션 
	public List<QnADto> selectAllQnAList();

	public Map<String, String> updateLikeCount(String qnaId, String loggedinId);
	
	


	

}
