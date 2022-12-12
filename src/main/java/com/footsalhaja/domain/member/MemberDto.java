package com.footsalhaja.domain.member;

import java.time.LocalDateTime;
import java.util.List;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.free.FreeReplyDto;

import lombok.Data;

@Data
public class MemberDto {
// 현재 member테이블 의 컬럼들 
//( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission )

	private String userId; //Primary Key varchar(50)
	private String name;
	private String password;
	private String email;
	private String nickName;
	
	private int birthYY;
	private int birthMM;
	private int birthDD;
	
	private String phone;
	private String personalGender; //성별 M 또는 F
	private String activityArea;   //활동지역 
	private String permission;     //허가 0 또는 1 으로 권한 ?  디폰트 0 설정함.

	private LocalDateTime insertDatetime; //필요하다면, 사용하세요 
	//private LocalDateTime deleteDatetime;
	
	private List<String> auth; 

	//마이페이지 내글 보기(아카데미게시판) 
	private List<BoardDto> userAbList;
	
	//마이페이지 내글 보기 (자유게시판)
	private List<com.footsalhaja.domain.free.BoardDto> userFbList;
	
	//마이페이지 내가 쓴 댓글 보기 (List<AcademyReplyDto, FreeReplyDto> 가 안되서 따로 dto 생성해서 해봄.. 어떻게 해야 따로 dto생성없이 할 수 있나?
	private List<AcademyReplyDto> userAbReplyList;
	
	private List<FreeReplyDto> userFbReplyList;
	
	private List<BoardDto> userAbLikeList;
	
	private List<com.footsalhaja.domain.free.BoardDto> userFbLikeList;

}

