package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnADto {

	private int qnaId;
	private String userId;
	private String nickname;
	private String qnaContent;
	private String qnaReply;
	
	private LocalDateTime insertDatetime;
	private LocalDateTime deleteDatetime;
	
}
