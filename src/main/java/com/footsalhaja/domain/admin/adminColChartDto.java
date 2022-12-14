package com.footsalhaja.domain.admin;

import java.time.LocalDate;

import lombok.Data;

@Data
public class adminColChartDto {
	
	//private int chartId;
	private LocalDate date;
	
	private int visitCount;
	private int bookedCount;
	private int qnaCount;
	
}
