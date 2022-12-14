package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnALikeDto {
	private int qnaLikeId;
	private int qnaId;
	private LocalDateTime insertDatetime;
}
