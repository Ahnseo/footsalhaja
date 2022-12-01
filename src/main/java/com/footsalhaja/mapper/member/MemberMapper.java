package com.footsalhaja.mapper.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.member.MemberDto;

@Mapper
public interface MemberMapper {
	
	//회원가입 
	public int insertMember(MemberDto member);
	
	//회원목록
	public List <MemberDto> selectMemberList();

	//RequestParam 으로 받아온 userId 로 db 요청
	public MemberDto selectMemberInfoByUserId(String userId);
	
	
}
