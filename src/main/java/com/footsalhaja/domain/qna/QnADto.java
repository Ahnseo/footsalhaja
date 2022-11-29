package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnADto {
	// id, category ,content, userId, status, qnaReply(x replyDto만들), insertDatetime  
	private int qnaId;
	private String category;
	private String title;
	private String content;
	private String userId;
	private String status;
	//private String qnaReply;
	
	private LocalDateTime insertDatetime;
	private LocalDateTime deleteDatetime;
	
}
