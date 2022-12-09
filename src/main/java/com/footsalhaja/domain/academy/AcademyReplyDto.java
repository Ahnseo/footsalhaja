package com.footsalhaja.domain.academy;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class AcademyReplyDto {
	private int ab_replyNumber;
	private int ab_number;
	private String ab_replyContent;
	private String member_userId;
	private boolean editable;
	
	
	private LocalDateTime ab_replyInsertDatetime;
	
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime oneDayBefore = now.minusDays(1);
		LocalDateTime oneMonthBefore = now.minusMonths(1);
		LocalDateTime oneYearBefore = now.minusYears(1);
		
		String result = "";
		// 작성일과 현재가 
		
		if (oneDayBefore.isBefore(ab_replyInsertDatetime)) {
			// 하루 차이면 시간을 출력
			result = ab_replyInsertDatetime.toLocalTime().toString();
		} else if (oneMonthBefore.isBefore(ab_replyInsertDatetime)) {
			// 1달 내이면 n일 전
			result = Period.between(ab_replyInsertDatetime.toLocalDate(), now.toLocalDate())
						.getDays() + "일 전";
		} else if (oneYearBefore.isBefore(ab_replyInsertDatetime)) {
			// 1년 이내면 n달 전
			result = Period.between(ab_replyInsertDatetime.toLocalDate(), now.toLocalDate())
					.get(ChronoUnit.MONTHS) + "달 전";
		} else {
			// n년 전
			result = Period.between(ab_replyInsertDatetime.toLocalDate(), now.toLocalDate())
					.getYears() + "년 전";
		}
		
		return result;
	}
}
