package com.footsalhaja.domain.main;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class ReplyDto {
	private int replyId;
	private String replyContent;
	private String nickName;
	private int bookId;
	private String userId;
	private String member_userId;
	private int book_bookId;
	
	private boolean editable;

	 private String reparent;
	 private String redepth;
	 private Integer reorder;
	 
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime insertDatetime;
	
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime oneDayBefore = now.minusDays(1);
		LocalDateTime oneMonthBefore = now.minusMonths(1);
		LocalDateTime oneYearBefore = now.minusYears(1);
		
		String result = "";
		
		if (oneDayBefore.isBefore(insertDatetime)) {
			// 하루 차이면 시간을 출력
			result = insertDatetime.toLocalTime().toString();
		} else if (oneMonthBefore.isBefore(insertDatetime)) {
			// 1달 내이면 n일 전
			result = Period.between(insertDatetime.toLocalDate(), now.toLocalDate())
						.getDays() + "일 전";
		} else if (oneYearBefore.isBefore(insertDatetime)) {
			// 1년 이내면 n달 전
			result = Period.between(insertDatetime.toLocalDate(), now.toLocalDate())
					.get(ChronoUnit.MONTHS) + "달 전";
		} else {
			// n년 전
			result = Period.between(insertDatetime.toLocalDate(), now.toLocalDate())
					.getYears() + "년 전";
		}
		return result;
	}
}
