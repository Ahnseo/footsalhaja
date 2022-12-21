package com.footsalhaja.service.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;
import com.footsalhaja.mapper.qna.QnAMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Transactional
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;
	
	//Create QnABoard
	@Override
	public int insertQnABoard(QnADto qnaBoard, MultipartFile[] files) {
		//String nickName = memberMapper.selectNickNameByMember();
		//model.addAttribute("memberNickName", nickName); 나중에 로그인 만들어지면 사용할것. 
		
		int cnt = qnaMapper.insertQnABoard(qnaBoard);
		int qnaId = qnaBoard.getQnaId();
		
		
		for (MultipartFile file : files) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				qnaMapper.insertQnAFiles(qnaId, file.getOriginalFilename());
				
				uploadFile(qnaId, file);
			}
		}
		
		return cnt;
	}
	// ### S3 파일업로드 메소드 ###
	private void uploadFile(int id, MultipartFile file) {
		try {
			// S3에 파일 저장
			// 키 생성
			String key = "qna/" + id + "/" + file.getOriginalFilename();
			
			// putObjectRequest
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(key)
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			// requestBody
			RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			
			// object(파일) 올리기
			s3Client.putObject(putObjectRequest, requestBody);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	// 답변완료된 모든 리스트 가져오기 mainQnABoard 
	@Override
	public List<QnADto> selectQnAListByStatusDone(int page, QnAPageInfo qnaPageInfo, String type, String keyword, String c) {
		//all accusation payment facility etc
		
		//System.out.println("###### c :"+c);
		String category = "";
		switch (c) {
		case "accusation":
			category = "신고/제재";
			break;
		case "payment":
			category = "결제문의";
			break;
		case "facility":
			category = "시설문의";
			break;
		case "etc":
			category = "기타문의";
			break;
		
		}
		//System.out.println("category::::"+category);
		
		// 페이지네이션 추가
		int records = 10; // 10 rows 씩 목록에 나타냅니다  
		int offset = (page - 1) * records; //page=2 : 11~20 rows ,  page=3 : 21~30 rows 나타냄 
		String status = "답변완료";
		int countAllQnAByDone = qnaMapper.countAllQnAByDone(type, "%"+keyword+"%", status, c, category);
		//System.out.println("done 문의 갯수 : " + countAllQnAByDone + "개");
		int lastPageNumber = (countAllQnAByDone - 1) / records + 1;
		//System.out.println("lastPageNumber:"+lastPageNumber);

		int leftPageNumber = (page - 1) / 10 * 10 + 1;	
		//System.out.println("leftPageNumber : " + leftPageNumber);
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
		
	
		
		return qnaMapper.selectQnAListByStatusDone(offset, records, "%"+keyword+"%", type, status, c, category);
	}
	@Override
	public List<QnADto> myQnAList(String userId, int page, QnAPageInfo qnaPageInfo, String type, String keyword, String c) {
		//카테코리 기능 추가 
		String category = "";
		switch (c) {
		case "accusation":
			category = "신고/제재";
			break;
		case "payment":
			category = "결제문의";
			break;
		case "facility":
			category = "시설문의";
			break;
		case "etc":
			category = "기타문의";
			break;
		
		}
		
		// 페이지네이션 추가
		int records = 10; // 10 rows 씩 목록에 나타냅니다  
		int offset = (page - 1) * records; //page=2 : 11~20 rows ,  page=3 : 21~30 rows 나타냄 
		
		int countAllByUserId = qnaMapper.countAllQnAByUserId(userId, type, "%"+keyword+"%", c, category);
		//System.out.println("userId의 문의 갯수 : " + countAllByUserId + "개");
		int lastPageNumber = (countAllByUserId - 1) / records + 1;
		//                50 - 1 = 49 / 10 = 4.9 = 4 + 1 = 5 

		int leftPageNumber = (page - 1) / 10 * 10 + 1;
					// 2 - 1 = 1 /10 =0  *10 =0 + 1 => 1
					// 10 - 1 = 9/10 =0  *10 =0 + 1 => 1
					// 11 - 1 = 11/10=1  *10 =10 + 1 => 11	
		//System.out.println("leftPageNumber : " + leftPageNumber);
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
		
		return qnaMapper.myQnAList(userId, records, offset, type, "%"+keyword+"%", c, category);
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
		//Map<String, String> map = new HashMap<>();
		
		return qnaMapper.selectMyQnAGetByQnAIdAndUserId(userId, qnaId);
	}
	
	//updateMyQnABoard
	@Override
	public int updateMyQnABoard(QnADto modifiedQnA, List<String> removeFiles, MultipartFile[] addFiles) {
		
		if (removeFiles != null) {
			for (String fileName : removeFiles) {
				// 1. File 테이블에서 record 지우기
				qnaMapper.deleteQnAFileByQnAIdAndFileName(modifiedQnA.getQnaId(), fileName);
				// 2. S3 저장소에 실제 파일(object) 지우기
				deleteQnAFile(modifiedQnA.getQnaId(), fileName);
			}
		}
		if (addFiles != null) {
			for (MultipartFile file : addFiles) {
				if (file != null && file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					// File 테이블에 해당파일명 지우기 (중복 파일은 지우기 )
					qnaMapper.deleteQnAFileByQnAIdAndFileName(modifiedQnA.getQnaId(), fileName);
					
					// File 테이블에 파일명 추가
					qnaMapper.insertQnAFiles(modifiedQnA.getQnaId(), fileName);
					
					// S3 저장소에 실제 파일(object) 추가
					uploadFile(modifiedQnA.getQnaId(), file);
				}
				
			}
		}
		
		int cnt = qnaMapper.updateMyQnABoard(modifiedQnA);
		System.out.println("업뎃? : "+ cnt);
		
		return cnt;
	}
	// 파일 삭제 메소드 
	private void deleteQnAFile(int id, String fileName) {
		String key = "qna/" + id + "/" + fileName;
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3Client.deleteObject(deleteObjectRequest);
	}
	//######################################################################
	//좋아요 기능 만들기 
	@Override
	public Map<String, Object> updateLikeCount(String qnaId, String loggedinId) {
		System.out.println("service : " + qnaId);
		System.out.println("service : " + loggedinId);

		Map<String, Object> map = new HashMap<>();
		
		int cnt = qnaMapper.selectQnABoardLikeCount(qnaId,loggedinId);
		System.out.println("cnt: "+cnt);
		
		if(cnt == 0) {
			//게시물번호 + 유저ID에 의한 .. 좋아요 수가 0개 일때, 처음 좋아요 누르게 되니까 . 저장만 .
			qnaMapper.insertQnABoardLikeCount(qnaId,loggedinId);
			map.put("current", "liked");
			
		}else {		
			//게시물번호 + 유저ID에 의한 .. 좋아요 수가 1개 이면, 버튼 누르면 , 삭제  
			qnaMapper.deleteQnABoardLikeCount(qnaId, loggedinId);
			map.put("current", "not liked");
			
		}
		
		int count = qnaMapper.countAllLikeByQnAId(qnaId);
		// 현재 몇개인지
		System.out.println("count:"+ count);
		map.put("count", count);
		
		return map;
	}
	//######################################################################
	@Override
	public int deleteQnA(int qnaId) {
		//파일 삭제 
		QnADto qna = qnaMapper.selectQnAByQnaId(qnaId);
		//System.out.println("####"+qna);
		
		List<String> fileNames = qna.getFileName();
		
		if (fileNames != null) {
			for (String fileName : fileNames) {
				// s3 저장소의 파일 지우기
				deleteQnAFile(qnaId, fileName);
				//db 에 파일 기록 지우기 
				qnaMapper.deleteQnAFileByQnAIdAndFileName(qnaId, fileName);
			}
		}
		
		//문의글의 여러 좋아요 삭제 
		qnaMapper.deleteLikesByqnaId(qnaId);
		//여러댓글삭제  by 답변의 id  
		qnaMapper.deleteAllQnAReplyById(qnaId);
		//답변삭제 by 답변 id
		qnaMapper.deleteAnswerBYqnaId(qnaId);
		
		
		//문의 게시물 삭제
		int cnt = qnaMapper.deleteQnA(qnaId);
		
		return cnt;
	}
	//######################################################################
	//QnA 답변 저장
	@Override
	public int insertQnAReply(QnAReplyDto qnaReply) {
		System.out.println("servi:"+ qnaReply);
		int qnaId = qnaReply.getQnaId();
		int cnt = qnaMapper.insertQnAReply(qnaReply);
		if(cnt == 1) {
			String status = "답변완료";
			qnaMapper.updateQnAStatus(qnaId, status);
		}
		return cnt;
	}
	//QnA 답변 수정 
	@Override
	public int updateAnswerByAnswerId(int answerId, String content) {
		int cnt = qnaMapper.updateAnswerByAnswerId(answerId, content);
		return cnt;
	}
	//QnA 답변 삭제 
	@Override
	public int deleteAnswerByAnswerId(QnAReplyDto qnaReply) {
		int qnaId = qnaReply.getQnaId();
		int qnaAnswerId = qnaReply.getQnaReplyId();
		System.out.println("@@@qnaAnswerId : "+qnaAnswerId);
		
		//1.답변에 대한 여러 댓글 삭제 
		int delAllReplies = qnaMapper.deleteQnAReplyByAnswerId(qnaAnswerId);
		System.out.println("###delAllReplies:"+delAllReplies);
		//2.답변 삭제 
		int cnt = qnaMapper.deleteAnswerByAnswerId(qnaAnswerId);
		if (cnt == 1){
			//3.QnABoard status 바꾸기 
			String status = "답변대기";
			qnaMapper.updateQnAStatus(qnaId, status);
		}
		return cnt;
	}
	//QnA 답변 1개 가져오기 
	@Override
	public QnAReplyDto selectQnAReply(QnAReplyDto qnaReply) {
		
		return qnaMapper.selectQnAReply(qnaReply);
	}
	//######################################################################
	//QnA 답변에대한 댓글 쓰기
	@Override
	public int insertQnAReplyToAnswer(QnAReplyToAnswerDto qnaReplyToAnswer) {
		
		System.out.println("답변 id == "+qnaReplyToAnswer.getQnaReplyId());
		
		
		int cnt = qnaMapper.insertQnAReplyToAnswer(qnaReplyToAnswer);
		return cnt;
	}
	@Override
	public int updateReplyById(int qnaReplyToAnswerId, String content) {
		int cnt = qnaMapper.updateReplyById(qnaReplyToAnswerId, content);
		return cnt;
	}
	
	//댓글 리스트 가져오기 다시!! js
	@Override
	public List<QnAReplyToAnswerDto> selectReplyList(int answerId,String username) {
		return qnaMapper.selectReplyList(answerId, username);
	}
	@Override
	public QnAReplyToAnswerDto selectQnAReplyById(int replyId) {
		
		return qnaMapper.selectQnAReplyById(replyId);
	}
	
	
	//QnA답변에 대한 댓글 리스트 가져오기
	@Override
	public List<QnAReplyToAnswerDto> selectQnAReplyToAnswerList(int qnaReplyId){	
		return qnaMapper.selectQnAReplyToAnswerList(qnaReplyId);
	}
	//QnA댓글 삭제
	@Override
	public int deleteQnAReplyByReplyId(int qnaReplyToAnswerId) {
		return qnaMapper.deleteQnAReplyByReplyId(qnaReplyToAnswerId);
	}
	//######################################################################
	
}
