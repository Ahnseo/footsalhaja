package com.footsalhaja.service.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.member.MemberPageInfo;
import com.footsalhaja.mapper.member.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	//회원가입(등록) 또는 회원정보 수정
	@Override
	public int insertMember(MemberDto member) {
		// name,value 를 -> member Bean 으로 받고, MemberDto 타입으로 리턴 !! 
		// 등록되면 cnt=1, 안되면 cnt=0  
		int cnt = memberMapper.insertMember(member);
		//System.out.println(cnt);
		return cnt; 
	}
	
	//회원목록
	@Override
	public List<MemberDto> selectMemberList(int page, MemberPageInfo memberPageInfo, String keyword, String type) {
		int records = 10;
		int offset = (page - 1) * records; //?page=2 =>  11~20 레코드들.  offset = 10  이어야함 .
		int countAllMember = memberMapper.selectAllMemberCount(type, "%"+keyword+"%");
		// 11명 => lastP =2 .. 11 - 1 /10 +1 ? 
		//  21 => 3             21-1/10 =2 +1
		int lastPageNumber = (countAllMember - 1) / records + 1;
		// page보기 1~10 개중...현재 page=2 라면,, 왼쪽에 1 오른쪽 8
		// page보기 11~20 개중...현재 page=15 라면,, 왼쪽에 4(11,12,13,14) 오른쪽 5 (16,17,18,19,20) =>leftPageNumber=11
							//15 -1 /10 =1 *10 =10 +1 =>11
							//27 -1 /10 =2 *10 =20 +1 =>21
		int leftPageNumber = (page - 1) / 10 * 10 + 1;
		int rightPageNumber = leftPageNumber + 9; //11 ~ 20 , 21 ~ 30, 31 ~ 40 
		rightPageNumber = Math.min(rightPageNumber, lastPageNumber);
		
		int jumpPrevPageNumber = (page - 1) / 10 * 10 - 9; 
		int jumpNextPageNumber = (page - 1) / 10 * 10 + 11;  
		boolean hasPrevButton = page > 10;
		boolean hasNextButton = page <= (lastPageNumber - 1) /10 * 10 ;
		
		memberPageInfo.setCurrentPageNumber(page);
		memberPageInfo.setLastPageNumber(lastPageNumber);
		memberPageInfo.setLeftPageNumber(leftPageNumber);
		memberPageInfo.setRightPageNumber(rightPageNumber);
		memberPageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		memberPageInfo.setJumpPrevPageNumber(jumpNextPageNumber);
		memberPageInfo.setHasPrevButton(hasPrevButton);
		memberPageInfo.setHasNextButton(hasNextButton);
		
		return memberMapper.selectMemberList(offset, records, "%"+keyword+"%", type);
	}
	
	//userId로 회원정보 가져오기 
	@Override
	public MemberDto selectMemberInfoByUserId(String userId) {
		
		return memberMapper.selectMemberInfoByUserId(userId);
	}
	
	// userId로 회원정보 삭제하기 (modify.jsp 와 delete에 사용할 것 )
	@Override
	public int deleteMemberInfoByUserId(String userId) {
		//회원탈퇴 FK Authority ByUserId
		memberMapper.deleteAuthorityByUserId(userId);
		//회원탈퇴 member ByUserId
		int cnt = memberMapper.deleteMemberInfoByUserId(userId);
		return cnt;
	}
	
	@Override
	public int updateMemberInfoByUserId(MemberDto memberModifiedValues) {
		int cnt = memberMapper.updateMemberInfoByUserId(memberModifiedValues);
		System.out.println(cnt);
		System.out.println(memberModifiedValues);
		return cnt;
	}
	
	//내글 보기 (아카데미 게시판)
	@Override
	public MemberDto getUserAbList(String userId) {
		return memberMapper.getUserAbList(userId);
	}
	//내글 보기 (자유 게시판)
	@Override
	public MemberDto getUserFbList(String userId) {
		return memberMapper.getUserFbList(userId);
	}
	
	//내가 쓴 댓글 보기
	@Override
	public List<MemberDto> getUserReplyList(String userId) {
		List<MemberDto> list = new ArrayList<>();
		MemberDto userAbReplyList = memberMapper.getUserAbReplyList(userId);
		MemberDto userFbReplyList = memberMapper.getUserFbReplyList(userId);
		
		list.add(userAbReplyList); 
		list.add(userFbReplyList);

		return list;
	}
	
	@Override
	public List<MemberDto> getUserLikeList(String userId) {
		List<MemberDto> list = new ArrayList<>();
		
		MemberDto userAbLikeList = memberMapper.getUserAbLikeList(userId);
		MemberDto userFbLikeList = memberMapper.getUserFbLikeList(userId);
		
		list.add(userAbLikeList);
		list.add(userFbLikeList);
		
		return list;
	}
	
}
