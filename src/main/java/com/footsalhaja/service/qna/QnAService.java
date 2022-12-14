package com.footsalhaja.service.qna;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;

public interface QnAService {

	public int insertQnABoard(QnADto qnaBoard,  MultipartFile[] files);
	
	public List<QnADto> myQnAList(String userId, int page, QnAPageInfo qnaPageInfo, String type, String keyword, String c);
	
	public QnADto selectMyQnAListByUserId(String userId);

	public List<FAQDto> selectFAQList();

	public QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId);

	public Map<String, Object> updateLikeCount(String qnaId, String loggedinId);

	public int insertQnAReply(QnAReplyDto qnaReply);
	public QnAReplyDto selectQnAReply(QnAReplyDto qnaReply);

	public int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer);

	public List<QnAReplyToAnswerDto> selectQnAReplyToAnswerList(int qnaReplyId);

	public int deleteAnswerByAnswerId(QnAReplyDto qnaReply);

	public int deleteQnAReplyByReplyId(int qnaReplyToAnswerId);
	
	public int deleteQnA(int qnaId);

	public int updateMyQnABoard(QnADto modifiedQnA, List<String> removeFiles, MultipartFile[] addFiles);

	public List<QnADto> selectQnAListByStatusDone(int page, QnAPageInfo qnaPageInfo, String type, String keyword, String c);

	public int updateAnswerByAnswerId(int answerId, String content);

	public int updateReplyById(int qnaReplyToAnswerId, String content);

	public List<QnAReplyToAnswerDto> selectReplyList(int answerId, String username);

	public QnAReplyToAnswerDto selectQnAReplyById(int replyId);
	


	
	


	

}
