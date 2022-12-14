package com.footsalhaja.domain.academy;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.List;

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
	private int countLike;
	private boolean liked;
	private int ab_viewCount;
	private List<String> ab_fileName;
	private int countFile;
	private String nickName;
	private int ranking;
	
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime oneDayBefore = now.minusDays(1);
		LocalDateTime oneMonthBefore = now.minusMonths(1);
		LocalDateTime oneYearBefore = now.minusYears(1);

		String result = "";
		// 작성일과 현재가

		if (oneDayBefore.isBefore(ab_insertDatetime)) {
			// 하루 차이면 시간을 출력
			result = ab_insertDatetime.toLocalTime().toString();
		} else if (oneMonthBefore.isBefore(ab_insertDatetime)) {
			// 1달 내이면 n일 전
			result = Period.between(ab_insertDatetime.toLocalDate(), now.toLocalDate())
					.getDays() + "일 전";
		} else if (oneYearBefore.isBefore(ab_insertDatetime)) {
			// 1년 이내면 n달 전
			result = Period.between(ab_insertDatetime.toLocalDate(), now.toLocalDate())
					.get(ChronoUnit.MONTHS) + "달 전";
		} else {
			// n년 전
			result = Period.between(ab_insertDatetime.toLocalDate(), now.toLocalDate())
					.getYears() + "년 전";
		}

		return result;
	}
}
