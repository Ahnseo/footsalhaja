package com.footsalhaja.domain.free;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class FreeReplyDto {
	private int fb_replyNumber; // 댓글번호pk
	private String fb_replyContent; //댓글내용
	private int freeBoard_fb_number; // 프리보드 게시글번호
	private String member_userId; 
	
	private boolean editable; // 로그인한 아이디가 댓글작성자인지
	
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime fb_inserDatetime; //댓글작성시간
	
	// 댓글 입력시간 변경
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now(); // 현재시간
		LocalDateTime oneDayBefore = now.minusDays(1); // 현재로부터 하루전
		LocalDateTime oneMonthBefore = now.minusMonths(1); // 한달전
		LocalDateTime oneYearBefore = now.minusYears(1); // 일년전
		String result = "";
		
		// 댓글작성시간과 현재시간이
		// 하루 차이일 경우 시간출력
		if(oneDayBefore.isBefore(fb_inserDatetime)) {
			result = fb_inserDatetime.toLocalTime().toString();
			
		// 1달 이내면 n일전
		} else if (oneMonthBefore.isBefore(fb_inserDatetime)){
			result = Period.between(fb_inserDatetime.toLocalDate(), now.toLocalDate())
					.getDays() + "일 전";
			
		// 1년 이내면 n달전
		}else if (oneYearBefore.isBefore(fb_inserDatetime)){
			result = Period.between(fb_inserDatetime.toLocalDate(), now.toLocalDate())
					.get(ChronoUnit.MONTHS) + "달 전";
			
		// n년전
		}else {
			result = Period.between(fb_inserDatetime.toLocalDate(), now.toLocalDate())
					.getYears() + "년 전";
		}
		
		return result;
	}
	
	
	
}
