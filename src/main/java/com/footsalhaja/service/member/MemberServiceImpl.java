package com.footsalhaja.service.member;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.catalina.mapper.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.academy.BoardDto;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.domain.member.MemberPageInfo;
import com.footsalhaja.mapper.member.MemberMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;
	

	@Override
	public MemberDto getByEmail(String email) {
		return memberMapper.selectByEmail(email);
	};
	
	@Override
	public MemberDto  getByNickName(String nickName) {
		return memberMapper.selectByNickName(nickName);
	};
	
	
	@Override
	public MemberDto getById(String userId){
		return memberMapper.selectByUserId(userId);
	}
  
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
	public List<Object> selectMemberInfoByUserId(String userId) {
		List<Object> list = new ArrayList<>();
		
		MemberDto memberInfo = memberMapper.selectMemberInfoByUserId(userId);
		
		Map<String, Integer> countActivity = new HashMap<>();

		int countAllAblist = memberMapper.countAllAblist(userId);
		int countAllFblist = memberMapper.countAllFblist(userId);
		int countAllMainlist = memberMapper.countAllMainlist(userId);
		int countAbReplyList = memberMapper.countAbReplyList(userId);
		int countFbReplyList = memberMapper.countFbReplyList(userId);
		int countMainReplyList = memberMapper.countMainReplyList(userId);
		int countUserAbLike = memberMapper.countUserAbLike(userId);
		int countUserFbLike = memberMapper.countUserFbLike(userId);
		
		countActivity.put("countAllAblist", countAllAblist);
		countActivity.put("countAllFblist", countAllFblist);
		countActivity.put("countAllMainlist", countAllMainlist);
		countActivity.put("countAbReplyList", countAbReplyList);
		countActivity.put("countFbReplyList", countFbReplyList);
		countActivity.put("countMainReplyList", countMainReplyList);
		countActivity.put("countUserAbLike", countUserAbLike);
		countActivity.put("countUserFbLike", countUserFbLike);
		
		list.add(memberInfo);
		list.add(countActivity);
		
		return list;
	}
	
	// userId로 회원정보 삭제하기 (modify.jsp 와 delete에 사용할 것 )
	@Override
	public int deleteMemberInfoByUserId(String userId) {
		//프로필 이미지 삭제
		String profileImg = memberMapper.selectMemberInfoByUserId(userId).getProfileImg();
		
		if (profileImg != null) {
			// s3 저장소의 프로필 지우기
			deleteFile(userId, profileImg);
		
		}
		
		//DB 프로필 지우기
		memberMapper.deleteProfileImgByUserId(userId);
		//회원탈퇴 게시물 지우기
		memberMapper.deleteMemberDocumentsByUserId(userId);
		//회원탈퇴 게시물 댓글 지우기
		memberMapper.deleteMemberReplysByUserId(userId);
		//회원탈퇴 좋아요 지우기
		memberMapper.deleteMemberLikesByUserId(userId);
		
		if (profileImg != null) {
			// s3 저장소의 프로필 지우기
			deleteFile(userId, profileImg);
		
		}
		
		//DB 프로필 지우기
		memberMapper.deleteProfileImgByUserId(userId);
		//회원탈퇴 게시물 지우기
		memberMapper.deleteMemberDocumentsByUserId(userId);
		//회원탈퇴 게시물 댓글 지우기
		memberMapper.deleteMemberReplysByUserId(userId);
		//회원탈퇴 좋아요 지우기
		memberMapper.deleteMemberLikesByUserId(userId);
		//회원탈퇴 FK Authority ByUserId
		memberMapper.deleteAuthorityByUserId(userId);
		//회원탈퇴 member ByUserId
		int cnt = memberMapper.deleteMemberInfoByUserId(userId);
		return cnt;
	}
	
	private void deleteFile(String userId, String fileName) {
		String key = "user_profile/" + userId + "/" + fileName;
		
		System.out.println(key);
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3Client.deleteObject(deleteObjectRequest);
	}
	
	private void uploadFile(String userId, MultipartFile file) {
		try {
			// S3에 파일 저장
			// 키 생성
			String key = "user_profile/" + userId + "/" + file.getOriginalFilename();
			
			// putObjectRequest
			PutObjectRequest putObjectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(key)
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			// requestBody
			RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			
			// object(파일) 올리기
			s3Client.putObject(putObjectRequest, requestBody);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public int updateMemberInfoByUserId(MemberDto memberModifiedValues, MultipartFile file) {
		String userId = memberModifiedValues.getUserId();
		String oldProfile  = memberMapper.getProfileImgByUserId(userId);
		
		System.out.println(oldProfile);
		
		if (file != null && file.getSize() > 0) {
			//기존 프로필 삭제
			System.out.println("기존 프로필"+oldProfile);
			deleteFile(memberModifiedValues.getUserId(), oldProfile);
			memberMapper.deleteProfileImgByUserId(memberModifiedValues.getUserId());
			
			memberMapper.insertprofileImg(memberModifiedValues.getUserId(), file.getOriginalFilename());
			// 파일 저장
			uploadFile(memberModifiedValues.getUserId(),file);
			System.out.println("새프로필: "+file.getOriginalFilename());
		}
		
		/*
		 * int cnt = memberMapper.updateMemberInfoByUserId(memberModifiedValues); 
		 * //System.out.println(cnt);
		 * System.out.println("serviceAuth : "+memberModifiedValues.getAuth()); 
		 * return cnt;
		 */
		
		int cnt = memberMapper.updateMemberInfoByUserId(memberModifiedValues);
		
		return cnt;
		
	}
	
	//회원권한 추가하기 
	@Override
	public int updateMemberAuth(String userId, String addAuth) {

		
		int cnt = memberMapper.updateMemberAuth(userId, addAuth);
		
		return cnt;
	}
	
	//내글 보기 (아카데미 게시판)
	@Override
	public MemberDto getUserAbList(String userId, int page, MemberPageInfo pageInfo) {
		
		int records = 10;
		int offset = (page - 1) * records;
		
		int countAll = memberMapper.countAllAblist(userId);

		int lastPage = (countAll - 1) / records + 1; // 마지막 페이지
		
		// 5페이지씩 보이게
		int leftPageNumber = (page - 1) / 5 * 5 + 1;
		int rightPageNumber = leftPageNumber + 4;
		rightPageNumber = Math.min(rightPageNumber, lastPage);
		
		// 이전 버튼 유무
		boolean hasPrevButton = page > 5;
		// 다음 버튼 유무
		boolean hasNextButton = page <= ((lastPage - 1) / 5 * 5);
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 5 * 5 - 4;
		// 다음버튼 눌렀을 때 가는 페이지 번호
		int jumpNextPageNumber = (page - 1) / 5 * 5 + 6; 
		
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);
		pageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		pageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		pageInfo.setCurrentPageNumber(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setLastPageNumber(lastPage);
		
		return memberMapper.getUserAbList(userId, offset, records);
	}
	//내글 보기 (자유 게시판)
	@Override
	public MemberDto getUserFbList(String userId, int page, MemberPageInfo pageInfo) {
		int records = 10;
		int offset = (page - 1) * records;
		
		int countAll = memberMapper.countAllFblist(userId);

		int lastPage = (countAll - 1) / records + 1; // 마지막 페이지
		
		// 5페이지씩 보이게
		int leftPageNumber = (page - 1) / 5 * 5 + 1;
		int rightPageNumber = leftPageNumber + 4;
		rightPageNumber = Math.min(rightPageNumber, lastPage);
		
		// 이전 버튼 유무
		boolean hasPrevButton = page > 5;
		// 다음 버튼 유무
		boolean hasNextButton = page <= ((lastPage - 1) / 5 * 5);
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 5 * 5 - 4;
		// 다음버튼 눌렀을 때 가는 페이지 번호
		int jumpNextPageNumber = (page - 1) / 5 * 5 + 6; 
		
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);
		pageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		pageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		pageInfo.setCurrentPageNumber(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setLastPageNumber(lastPage);
		
		return memberMapper.getUserFbList(userId, offset, records);
	}
	
	//내글 보기 (메인)
	@Override
	public MemberDto getUserMainList(String userId, int page, MemberPageInfo pageInfo) {
		int records = 10;
		int offset = (page - 1) * records;
		
		int countAll = memberMapper.countAllMainlist(userId);

		int lastPage = (countAll - 1) / records + 1; // 마지막 페이지
		
		// 5페이지씩 보이게
		int leftPageNumber = (page - 1) / 5 * 5 + 1;
		int rightPageNumber = leftPageNumber + 4;
		rightPageNumber = Math.min(rightPageNumber, lastPage);
		
		// 이전 버튼 유무
		boolean hasPrevButton = page > 5;
		// 다음 버튼 유무
		boolean hasNextButton = page <= ((lastPage - 1) / 5 * 5);
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 5 * 5 - 4;
		// 다음버튼 눌렀을 때 가는 페이지 번호
		int jumpNextPageNumber = (page - 1) / 5 * 5 + 6; 
		
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);
		pageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		pageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		pageInfo.setCurrentPageNumber(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setLastPageNumber(lastPage);
		
		return memberMapper.getUserMainList(userId, offset, records);
	}
	
	//내가 쓴 댓글 보기
	@Override
	public List<MemberDto> getUserReplyList(String userId) {
		List<MemberDto> list = new ArrayList<>();
		MemberDto userAbReplyList = memberMapper.getUserAbReplyList(userId);
		MemberDto userFbReplyList = memberMapper.getUserFbReplyList(userId);
		MemberDto userMainReplyList = memberMapper.getUserMainReplyList(userId);
		
		list.add(userAbReplyList); 
		list.add(userFbReplyList);
		list.add(userMainReplyList);
		
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
