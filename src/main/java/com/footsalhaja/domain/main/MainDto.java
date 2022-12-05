package com.footsalhaja.domain.main;

import java.time.LocalDateTime;


import lombok.Data;

@Data
public class MainDto {//book


	private int bookId;
	private String stadiumTitle;
	private String content;
	private String matchType;
	private String level;
	private String status;

	private LocalDateTime insertDatetime;
	private String teamGender;


	private String location;
	
	

	private String location_locationId;
	private String userId;
	private String nickName;

	private String bookDate;

	private String bookTime;

}
