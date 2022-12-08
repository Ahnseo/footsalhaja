package com.footsalhaja.mapper.qna;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;

@Mapper
public interface QnAMapper {

	//Create QnABoard
	int insertQnABoard(QnADto qnaBoard);
	
	//select myQnA TABLE by userId
	List<QnADto> myQnAList(String userId, int records, int offset);

	QnADto selectMyQnAListByUserId(String userId);
	
	//select all FAQ TABLE
	List<FAQDto> selectFAQList();
	
	//페이지네이션 하기위해 userId로 등록된 QnA 갯수 구하기 
	int countAllQnAByUserId(String userId);
	
	//myQnA 1개 정보 가져오기 by userId, qnaId
	QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId);

	//select All QnAList (관리자 전용)
	List<QnADto> selectAllQnAList(int offset, int records, String keyword, String type);
	
	//
	int countAllQnA(String type, String keyword);

	//QnA Id와 로그인된 Id로 좋아요기능 추가
	int selectQnABoardLikeCount(String qnaId, String loggedinId);
	int insertQnABoardLikeCount(String qnaId, String loggedinId);
	int deleteQnABoardLikeCount(String qnaId, String loggedinId);
	
	//QnA 답변 등록하기 (관리자/매니저)
	int insertQnAReply(QnAReplyDto qnaReply);
	//QnA 답변 리스트 가져오기
	List<QnAReplyDto> selectQnAReply(QnAReplyDto qnaReply);
	//QnA 답변에 대한 댓글쓰기 (모든 회원이용 가능)
	int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer);
	//QnA 답변에 대한 댓글리스트 모두 가져오기 (모든 회원이용 가능)
	List<QnAReplyToAnswerDto> selectQnAReplyToAnswerList(int qnaReplyId);
	
	
	
	
}
