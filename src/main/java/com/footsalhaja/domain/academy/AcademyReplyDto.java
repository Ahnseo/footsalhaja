package com.footsalhaja.domain.academy;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class AcademyReplyDto {
	private int ab_replyNumber;
	private int ab_number;
	private String ab_replyContent;
	private String member_userId;
	
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime ab_replyInsertDatetime;
}
