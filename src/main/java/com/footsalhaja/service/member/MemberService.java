package com.footsalhaja.service.member;

import java.util.List;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.member.MemberPageInfo;

public interface MemberService {

	int insertMember(MemberDto member);

	List<MemberDto> selectMemberList(int page, MemberPageInfo memberPageInfo, String keyword, String type);

	MemberDto selectMemberInfoByUserId(String userId);

	int deleteMemberInfoByUserId(String userId);

	int updateMemberInfoByUserId(MemberDto memberModifiedValues);
	
	MemberDto getUserAbList(String userId);
	
	MemberDto getUserFbList(String userId);
	
	List<MemberDto> getUserReplyList(String userId);
	
	List<MemberDto> getUserLikeList(String userId);

}
