package com.footsalhaja.domain.main;

import lombok.Data;

@Data
public class BookDto { // 리스트 화면에서 보일 element

	private int bookId;
	private String title;
	private String bookDate;
	private String bookTime;
	private String stadiumName;
	private String status;
	private String matchType;
	private String level;
	private String region;
	private String userId;
	private String nickName;
	
	
}
