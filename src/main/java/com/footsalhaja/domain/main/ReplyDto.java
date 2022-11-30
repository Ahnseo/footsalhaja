package com.footsalhaja.domain.main;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReplyDto {
	private int id;
	private String content;
	private LocalDateTime insertDatetime;
}
