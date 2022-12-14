package com.footsalhaja.domain.main;

import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class BookDto { // 리스트 화면에서 보일 element

	private int bookId;
	private String title;

	private String stadiumName;
	private int status;
	private int matchType;
	private int level;
	private int region;
	private String userId;
	private String nickName;
	private String teamGender;
	private String locationId;
	private String location_locationId;
	
	private Date datepickerSday;
	private Date datepickerEday;

	private int bookTime;
	private String bookDate;
	
}
