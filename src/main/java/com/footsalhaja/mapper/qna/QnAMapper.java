package com.footsalhaja.mapper.qna;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;

@Mapper
public interface QnAMapper {
	
	//select all FAQ TABLE
	List<FAQDto> selectFAQList();
	//Create QnABoard
	int insertQnABoard(QnADto qnaBoard);
	//select myQnA TABLE by userId
	List<QnADto> myQnAList(String userId, int records, int offset, String type, String keyword, String c, String category);
	//페이지네이션 하기위해 userId로 등록된 QnA 갯수 구하기 
	int countAllQnAByUserId(String userId, String type, String keyword, String c, String category);
	//모든 QnA게시물 가져오기 by userId 
	QnADto selectMyQnAListByUserId(String userId);
	//myQnA 1개 정보 가져오기 by userId, qnaId
	QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId);
	//select All QnAList (관리자 전용)
	List<QnADto> selectAllQnAList(int offset, int records, String keyword, String type, String c, String category, String s, String status);
	//페이지네이션 lastPageNumber에 필요한 값 
	int countAllQnA(String type, String keyword, String c, String category, String s, String status);
	//updateMyQnA게시물 
	int updateMyQnABoard(QnADto qna);
	//답변완료된 모든 리스트 불러오기
	List<QnADto> selectQnAListByStatusDone(int offset, int records, String keyword, String type, String status, String c, String category);
	//qnaMainBoard lastpage 만들기 위해 count 
	int countAllQnAByDone(String type, String keyword, String status, String c, String category);
	//####################################################################################
	//QnA Id와 로그인된 Id로 좋아요기능 추가
	int selectQnABoardLikeCount(String qnaId, String loggedinId);
	int insertQnABoardLikeCount(String qnaId, String loggedinId);
	int deleteQnABoardLikeCount(String qnaId, String loggedinId);
	int countAllLikeByQnAId(String qnaId);
	
	//####################################################################################
	//QnA 답변 등록하기 (관리자/매니저)
	int insertQnAReply(QnAReplyDto qnaReply);
	//QnA 답변 1개 가져오기
	QnAReplyDto selectQnAReply(QnAReplyDto qnaReply);
	//QnA답변 삭제하기 (관리자) 
	int deleteAnswerByAnswerId(int qnaReplyId);
	
	// 미완성 
	//답변 등록하면 -> QnABoard (status -> '답변완료' )
	int updateQnAStatus(int qnaId, String status);
	
	//####################################################################################
	//QnA 답변에 대한 댓글쓰기 (모든 회원이용 가능)
	int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer);
	//QnA 답변 수정
	int updateAnswerByAnswerId(int answerId, String content);
	//QnA 답변에 대한 댓글리스트 모두 가져오기 (모든 회원이용 가능)
	List<QnAReplyToAnswerDto> selectQnAReplyToAnswerList(int qnaReplyId);
	//QnA 댓글 삭제 버튼으로 하나의 댓글 삭제  
	int deleteQnAReplyByReplyId(int qnaReplyToAnswerId);
	//관리자의 답변id 1개 로 여러 댓글 삭제 
	int deleteQnAReplyByAnswerId(int qnaAnswerId);
	
	//####################################################################################
	//모든 댓글 리스트 가져오기 
	List<QnAReplyToAnswerDto> selectReplyList(int answerId, String userId);
	//id로 댓글 정보 가져오기(수정모달에 값넣기 위해 사용 ) 
	QnAReplyToAnswerDto selectQnAReplyById(int replyId);
	//댓글 수정 
	int updateReplyById(int qnaReplyToAnswerId, String content);
	//문의게시물 id 로 모든 좋아요 삭제 
	int deleteLikesByqnaId(int qnaId);
	//문의 게시물 id로 모든 댓글들을  삭제 
	int deleteAllQnAReplyById(int qnaId);
	//문의 삭제을 위한 답변삭제 
	int deleteAnswerBYqnaId(int qnaId);
	//문의 삭제 
	int deleteQnA(int qnaId);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
