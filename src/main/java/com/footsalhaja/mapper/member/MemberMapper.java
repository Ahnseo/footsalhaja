package com.footsalhaja.mapper.member;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.member.MemberDto;

@Mapper
public interface MemberMapper {
	
	//회원가입 
	public int insertMember(MemberDto member);

	//
	public MemberDto selectMemberInfoByUserId(String username);
	
	
}
