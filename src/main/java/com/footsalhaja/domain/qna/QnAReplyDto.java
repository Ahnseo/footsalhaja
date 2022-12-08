package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnAReplyDto {
	//qnaReplyId,qnaId,userId,writer,content,insertDatetime
	private int qnaReplyId;
	private int qnaId;
	private String userId;
	private String writer; //작성자 : 관리자 or 매니저 
	private String content;
	private LocalDateTime insertDatetime;
	
}
