package com.footsalhaja.domain.free;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class FreeReplyDto {
	private int fb_replyNumber; // 댓글번호pk
	private String fb_replyContent; //댓글내용
	private int freeBoard_fb_number; // 프리보드 게시글번호
	private String member_userId; 
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime fb_inserDatetime; //댓글작성시간
	
}
