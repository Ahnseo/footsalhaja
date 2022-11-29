package com.footsalhaja.mapper.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	public String selectNickNameByMember();
	
	
}
