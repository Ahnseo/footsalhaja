package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnAReplyToAnswerDto {
	//qnaReplyToAnswerId, qnaReplyId, qnaId, writer, content, userId, insertDatetime
	private int qnaReplyToAnswerId; //답변에 대한 댓글 ID
	private int qnaReplyId; //답변 번호
	private int qnaId; //게시물 번호 
	private String userId; //작성자 : 로그인한 모든 회원 , userId == writer 둘다 사용가능하게 해놓음.. 중복임.
	private String writer; //작성자 : 로그인한 모든 회원 
	private String content;
	private LocalDateTime insertDatetime;
}
