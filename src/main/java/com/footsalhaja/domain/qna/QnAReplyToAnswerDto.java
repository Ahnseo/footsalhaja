package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;

import lombok.Data;

@Data
public class QnAReplyToAnswerDto {
	//qnaReplyToAnswerId, qnaReplyId, qnaId, writer, content, userId, insertDatetime
	private int qnaReplyToAnswerId; //답변에 대한 댓글 ID
	private int qnaReplyId; //답변 번호
	private int qnaId; //게시물 번호 
	private String userId; //작성자 : 로그인한 모든 회원 , userId == writer 둘다 사용가능하게 해놓음.. 중복임.
	private String writer; //작성자 : 로그인한 모든 회원 
	private String content;
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
}
