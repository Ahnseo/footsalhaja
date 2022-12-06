package com.footsalhaja.mapper.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.member.MemberDto;

@Mapper
public interface MemberMapper {
	
	//회원가입 
	public int insertMember(MemberDto member);
	
	//회원목록( 페이지네이션+ type +keyword 검색기능 추가 )
	public List <MemberDto> selectMemberList(int offset, int records, String keyword, String type);

	//RequestParam 으로 받아온 userId 로 db 요청
	public MemberDto selectMemberInfoByUserId(String userId);
	
	public int updateMemberInfoByUserId(MemberDto memberModifiedValues);
		
	//회원탈퇴 (member ByUserId)
	public int deleteMemberInfoByUserId(String userId);
	//회원탈퇴 (authority ByUserId) 
	public void deleteAuthorityByUserId(String userId);
	
	//전체회원정보 검색가능하기 위해 select count(*) 
	public int selectAllMemberCount(String type, String keyword);
	
	
}
