package com.footsalhaja.service.qna;

import java.util.List;
import java.util.Map;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;

public interface QnAService {

	public int insertQnABoard(QnADto qnaBoard);
	
	public List<QnADto> myQnAList(String userId, int page, QnAPageInfo qnaPageInfo);
	
	public QnADto selectMyQnAListByUserId(String userId);

	public List<FAQDto> selectFAQList();

	public QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId);

	public Map<String, String> updateLikeCount(String qnaId, String loggedinId);

	public int insertQnAReply(QnAReplyDto qnaReply);
	public List<QnAReplyDto> selectQnAReply(QnAReplyDto qnaReply);

	public int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer);


	
	


	

}
