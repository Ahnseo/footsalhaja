package com.footsalhaja.domain.qna;

import lombok.Data;

@Data
public class QnAReplyDto {
	
	private int qnaId;
	private String userId;
	private String writer; //작성자 : 관리자 or 매니저 
	private String content;
}
