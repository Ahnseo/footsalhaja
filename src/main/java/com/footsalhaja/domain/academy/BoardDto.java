package com.footsalhaja.domain.academy;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BoardDto {

	private int ab_number;
	private String ab_title;
	private String ab_category;
	private String ab_content;
	private LocalDateTime ab_insertDatetime;
	//나중에 member테이블과 조인해서 닉네임으로 수정해야함
	private String member_userId;
	private int replyCnt;

}
