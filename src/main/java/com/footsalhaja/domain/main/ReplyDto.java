package com.footsalhaja.domain.main;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class ReplyDto {
	private int replyId;
	private String replyContent;
	private String writer;
	private String bookId;
	private String userId;
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime insertDatetime;
}
