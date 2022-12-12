package com.footsalhaja.domain.free;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import lombok.Data;

@Data
public class BoardDto {
	private int fb_number;
	private String fb_category;
	private String fb_content;
	private String fb_title;
	private String member_userId;
	private LocalDateTime fb_insertDatetime;
	private int fb_likeCount;
	private int fb_replyCount;
	private int fb_viewCount;
	
	private String nickName;
	private boolean liked;
	
	// 게시물 입력시간 변경
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now(); // 현재시간
		LocalDateTime oneDayBefore = now.minusDays(1); // 현재로부터 하루전
		LocalDateTime oneMonthBefore = now.minusMonths(1); // 한달전
		LocalDateTime oneYearBefore = now.minusYears(1); // 일년전
		String result = "";
		
		// 게시물 작성시간과 현재시간이
		// 하루 차이일 경우 시간출력
		if(oneDayBefore.isBefore(fb_insertDatetime)) {
			result = fb_insertDatetime.toLocalTime().toString();
			
		// 1달 이내면 n일전
		} else if (oneMonthBefore.isBefore(fb_insertDatetime)){
			result = Period.between(fb_insertDatetime.toLocalDate(), now.toLocalDate())
					.getDays() + "일 전";
			
		// 1년 이내면 n달전
		}else if (oneYearBefore.isBefore(fb_insertDatetime)){
			result = Period.between(fb_insertDatetime.toLocalDate(), now.toLocalDate())
					.get(ChronoUnit.MONTHS) + "달 전";
			
		// n년전
		}else {
			result = Period.between(fb_insertDatetime.toLocalDate(), now.toLocalDate())
					.getYears() + "년 전";
		}
		
		return result;
	}
	
}
