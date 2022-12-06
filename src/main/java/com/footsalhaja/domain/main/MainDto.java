package com.footsalhaja.domain.main;

import java.time.LocalDateTime;


import lombok.Data;

@Data
public class MainDto {

//#{title}, #{content}, #{matchType}, #{level}, #{status}, 
//#{bookDate}, #{teamGender}, #{location_locationId}, #{userId}, #{bookTime}
	private int bookId;
	private String title;
	private String content;
	private String matchType;
	private String level;
	private String status;
	private String region;
	private LocalDateTime insertDatetime;
	private String teamGender;

	private String location;

	private String location_locationId;
	private String userId;
	private String nickName;

	private String bookDate;
	private String bookTime;

	private float lat;
	private float lng;
}
