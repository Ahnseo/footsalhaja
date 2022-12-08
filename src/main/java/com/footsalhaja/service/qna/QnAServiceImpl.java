package com.footsalhaja.service.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;
import com.footsalhaja.mapper.qna.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
	//Create QnABoard
	@Override
	public int insertQnABoard(QnADto qnaBoard) {
		//String nickName = memberMapper.selectNickNameByMember();
		//model.addAttribute("memberNickName", nickName); 나중에 로그인 만들어지면 사용할것. 	
		int cnt = qnaMapper.insertQnABoard(qnaBoard);
		return cnt;
	}

	@Override
	public List<QnADto> myQnAList(String userId, int page, QnAPageInfo qnaPageInfo) {
		// 페이지네이션 추가
		int records = 2; // 10 rows 씩 목록에 나타냅니다  
		int offset = (page - 1) * records; //page=2 : 11~20 rows ,  page=3 : 21~30 rows 나타냄 
		
		int countAllByUserId = qnaMapper.countAllQnAByUserId(userId);
		System.out.println("userId의 문의 갯수 : " + countAllByUserId + "개");
		int lastPageNumber = (countAllByUserId - 1) / records + 1;
		//                50 - 1 = 49 / 10 = 4.9 = 4 + 1 = 5 

		int leftPageNumber = (page - 1) / 10 * 10 + 1;
					// 2 - 1 = 1 /10 =0  *10 =0 + 1 => 1
					// 10 - 1 = 9/10 =0  *10 =0 + 1 => 1
					// 11 - 1 = 11/10=1  *10 =10 + 1 => 11	
		System.out.println("leftPageNumber : " + leftPageNumber);
		int rightPageNumber = leftPageNumber + 9;
		rightPageNumber = Math.min(rightPageNumber, lastPageNumber);
		
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 10 * 10 - 9;
								//11   -1   /10=1 *10 -9 = 1
								//21   -1   /10=2 *10 -9 = 11
		int jumpNextPageNumber = (page - 1) / 10 * 10 + 11; 
								//10   -1   /10=0 *10 +11 = 11
								//20   -1   /10=1 *10 +11 = 21
		// 이전버튼 유무
		boolean hasPrevButton = page > 10;
		// 다음버튼 유무
		boolean hasNextButton = page <= ((lastPageNumber - 1) / 10 * 10);
							//	10	        10  - 1 = 9 /10 = 0 * 10 =  0   false				
							//	10	        11  - 1 = 11 /10 = 1 * 10 = 10   true
		qnaPageInfo.setCurrentPageNumber(page);
		qnaPageInfo.setLeftPageNumber(leftPageNumber);
		qnaPageInfo.setRightPageNumber(rightPageNumber);
		qnaPageInfo.setLastPageNumber(lastPageNumber);	
		qnaPageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);	
		qnaPageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		qnaPageInfo.setHasPrevButton(hasPrevButton);	
		qnaPageInfo.setHasNextButton(hasNextButton);
		return qnaMapper.myQnAList(userId, records, offset );
	}
	
	@Override
	public QnADto selectMyQnAListByUserId(String userId) {
		return qnaMapper.selectMyQnAListByUserId(userId);
	}
	@Override
	public List<FAQDto> selectFAQList() {
		return qnaMapper.selectFAQList();
	}
	@Override
	public QnADto selectMyQnAGetByQnAIdAndUserId(String userId, int qnaId) {
		return qnaMapper.selectMyQnAGetByQnAIdAndUserId(userId, qnaId);
	}
	
	//좋아요 기능 만들기 
	@Override
	public Map<String, String> updateLikeCount(String qnaId, String loggedinId) {
		//System.out.println("service : " + qnaId);
		//System.out.println("service : " + loggedinId);

		Map<String, String> map = new HashMap<>();
		
		int cnt = qnaMapper.selectQnABoardLikeCount(qnaId,loggedinId);
		System.out.println(cnt);
		
		if(cnt == 0) {
			qnaMapper.insertQnABoardLikeCount(qnaId,loggedinId);
			map.put("current", "liked");
			return map;
		}else {			
			qnaMapper.deleteQnABoardLikeCount(qnaId, loggedinId);
			map.put("current", "not liked");
			return map;
		}
		
	}
	//QnA 답변하기
	@Override
	public int insertQnAReply(QnAReplyDto qnaReply) {
		//System.out.println("servi:"+ qnaReply);
		int cnt = qnaMapper.insertQnAReply(qnaReply);
		return cnt;
	}
	@Override
	public List<QnAReplyDto> selectQnAReply(QnAReplyDto qnaReply) {
		
		return qnaMapper.selectQnAReply(qnaReply);
	}
	//QnA 답변에대한 댓글 쓰기
	@Override
	public int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer) {
		int cnt = qnaMapper.insertQnAReplyToAnswer(qnaReplyToAnswer);
		return cnt;
	}
	//QnA답변에 대한 댓글 리스트 가져오기
	@Override
	public List<QnAReplyToAnswerDto> selectQnAReplyToAnswerList(QnAReplyToAnswerDto qnaReplyToAnswer) {

		return qnaMapper.selectQnAReplyToAnswerList(qnaReplyToAnswer);
	}
	
}
