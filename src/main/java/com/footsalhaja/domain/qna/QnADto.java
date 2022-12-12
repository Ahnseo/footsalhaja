package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnADto {

	// id, category ,content, userId, status, qnaReply(x replyDto만들), insertDatetime  
	// qnaId category title status userId insertDatetime qnaReplyId
	private int qnaId;
	private String category;
	private String title;
	private String content;
	private String status; // 0= 처리중 / 1=처리완료
	private String userId;

	private LocalDateTime insertDatetime;
	private LocalDateTime deleteDatetime;
	
	//게시물의 답변 id ( LEFT JOIN )
	private int qnaReplyId;
	
}
