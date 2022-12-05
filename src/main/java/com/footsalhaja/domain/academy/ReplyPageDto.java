package com.footsalhaja.domain.academy;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
//객체 생성시 편리하도록 replyCnt, list를 생성자의 파라미터로 처리
@AllArgsConstructor
@Getter
public class ReplyPageDto {
	private int replyCnt;
	private List<AcademyReplyDto> list;
}
