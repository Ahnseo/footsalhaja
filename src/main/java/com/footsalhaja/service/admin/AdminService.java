package com.footsalhaja.service.admin;

import java.util.List;

import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;

public interface AdminService {
	
	//관리자가 볼수있는 모든 질문정보 얻기 int records, int offset 페이지네이션 
	public List<QnADto> selectAllQnAList(int page, QnAPageInfo qnaPageInfo, String keyword, String type);
	
}
