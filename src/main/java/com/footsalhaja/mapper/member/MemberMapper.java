package com.footsalhaja.mapper.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.BoardDto;
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
	
	//내글보기(아카데미 게시판)
	public MemberDto getUserAbList(String userId, int offset, int records);
	public int countAllAblist(String userId);
	
	//내글보기(자유 게시판)
	public MemberDto getUserFbList(String userId, int offset, int records);
	public int countAllFblist(String userId);
	
	//내글 보기(메인)
	public MemberDto getUserMainList(String userId, int offset, int records);
	public int countAllMainlist(String userId);
	
	//내 댓글보기
	public MemberDto getUserFbReplyList(String userId);
	public MemberDto getUserAbReplyList(String userId);
	public MemberDto getUserMainReplyList(String userId);
	
	//내가 좋아요한 글 보기
	public MemberDto getUserAbLikeList(String userId);
	public MemberDto getUserFbLikeList(String userId);

}
