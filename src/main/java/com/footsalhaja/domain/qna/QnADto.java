package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import lombok.Data;

@Data
public class QnADto {

	// id, category ,content, userId, status, qnaReply(x replyDto만들), insertDatetime  
	// qnaId category title status userId insertDatetime qnaReplyId
	private int qnaId;
	private String category;
	private String title;
	private String content;
	private String status; // 0= 처리중 / 1=처리완료
	private String userId;
	private LocalDateTime insertDatetime;
	public String getAgo() {
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime oneDayBefore = now.minusDays(1);
		LocalDateTime oneMonthBefore = now.minusMonths(1);
		LocalDateTime oneYearBefore = now.minusYears(1);

		String result = "";
		// 작성일과 현재가

		if (oneDayBefore.isBefore(insertDatetime)) {
			// 하루 차이면 시간을 출력
			
			result = insertDatetime.toLocalTime().toString();
		}else if (oneMonthBefore.isBefore(insertDatetime)) {
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
	
	//게시물의 답변 id ( LEFT JOIN )
	private int qnaReplyId;
	
		
}




