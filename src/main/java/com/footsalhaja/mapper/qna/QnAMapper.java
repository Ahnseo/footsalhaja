package com.footsalhaja.mapper.qna;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;

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
	
	
	
	
}
