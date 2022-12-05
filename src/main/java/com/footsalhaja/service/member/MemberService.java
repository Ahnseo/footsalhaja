package com.footsalhaja.service.member;

import java.util.List;

import com.footsalhaja.domain.member.MemberDto;

public interface MemberService {

	int insertMember(MemberDto member);

	List<MemberDto> selectMemberList();

	MemberDto selectMemberInfoByUserId(String userId);

	int deleteMemberInfoByUserId(String userId);

	int updateMemberInfoByUserId(MemberDto memberModifiedValues);
}
