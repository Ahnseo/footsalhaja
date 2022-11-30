package com.footsalhaja.domain.free;

import java.time.LocalDateTime;
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
}
