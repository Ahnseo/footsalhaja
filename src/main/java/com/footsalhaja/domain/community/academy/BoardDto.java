package com.footsalhaja.domain.community.academy;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDto {

	private int ab_number;
	private String ab_category;
	private String ab_content;
	private String ab_tilte;
	private Date ab_insertDateTime;
}
