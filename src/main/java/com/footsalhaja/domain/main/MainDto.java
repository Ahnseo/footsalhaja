package com.footsalhaja.domain.main;

import java.time.LocalDateTime;


import lombok.Data;

@Data
public class MainDto {//book

	private int bookId;
	private String stadiumTitle;
	private String content;
	private int matchType;
	private int level;
	private int status;
	private LocalDateTime bookDatetime;
	private LocalDateTime insertDatetime;
	private String teamGender;


	private String location;
	private String userId;
	private String nickName;

}
