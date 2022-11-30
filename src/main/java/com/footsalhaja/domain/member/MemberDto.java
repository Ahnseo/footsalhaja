package com.footsalhaja.domain.member;

import lombok.Data;

@Data
public class MemberDto {
// 현재 member테이블 의 컬럼들 ( userId, name, password, email, nickName, birthDate, activityArea, phone, profileImage, personalGender, permission )

	private String userId;
	private String name;
	private String password;
	private String email;
	private String nickName;
	private String birthDate;
	private String phone;
	private String personalGender; //성별 
	private String activityArea;   //활동지역 
	private String profileImage;   //프로필 이미지
	private String permission;     //허가 


	//private LocalDateTime insertDatetime; //필요하다면, 사용하세요 
	//private LocalDateTime deleteDatetime;
	//private List<String> auth;

}

