package com.footsalhaja.domain.qna;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnADto {

	private int qnaId;
<<<<<<< Updated upstream
	private String userId;
	private String nickname;
	private String qnaContent;
	private String qnaReply;
=======
	private String category;
	private String title;
	private String content;
	private String member_userId;
	private String member_nickName;
	private int status; // 0= 처리중 / 1=처리완료
	//private String qnaReply;
>>>>>>> Stashed changes
	
	private LocalDateTime insertDatetime;
	private LocalDateTime deleteDatetime;
	
}
