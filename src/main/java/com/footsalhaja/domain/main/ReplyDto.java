package com.footsalhaja.domain.main;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class ReplyDto {
	private int replyId;
	private String replyContent;
	private String nickName;
	private int bookId;
	private String userId;
	private String member_userId;
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime insertDatetime;
}
