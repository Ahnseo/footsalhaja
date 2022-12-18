package com.footsalhaja.service.member;

import java.util.List;


import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.academy.BoardDto;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.member.MemberPageInfo;

public interface MemberService {

	int insertMember(MemberDto member);

	List<MemberDto> selectMemberList(int page, MemberPageInfo memberPageInfo, String keyword, String type);

	List<Object> selectMemberInfoByUserId(String userId);


	int deleteMemberInfoByUserId(String userId);


	int updateMemberInfoByUserId(MemberDto memberModifiedValues, MultipartFile file);
	
	MemberDto getUserAbList(String userId, int page, MemberPageInfo pageInfo);
	
	MemberDto getUserFbList(String userId, int page, MemberPageInfo pageInfo);
	
	MemberDto getUserMainList(String userId, int page, MemberPageInfo pageInfo);
	
	List<MemberDto> getUserReplyList(String userId);
	
	List<MemberDto> getUserLikeList(String userId);

	int updateMemberAuth(String userId, List<String> addAuthorities);

	MemberDto getById(String userId);

	MemberDto getByEmail(String email);

	MemberDto getByNickName(String nickName);
	

}
