package com.footsalhaja.service.qna;

import org.springframework.stereotype.Service;
import java.util.List;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;

@Service
public interface QnAService {

	public int insertQnABoard(QnADto qnaBoard);
	
	public List<QnADto> myQnAList(String userId);
	
	public QnADto selectMyQnAListByUserId(String userId);

	public List<FAQDto> selectFAQList();

	

}
