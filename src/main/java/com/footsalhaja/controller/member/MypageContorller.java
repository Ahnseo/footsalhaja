package com.footsalhaja.controller.member;

import java.io.FileInputStream;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.domain.member.MemberDto;

import com.footsalhaja.domain.member.MemberPageInfo;

import com.footsalhaja.service.member.MemberService;

@Controller
@RequestMapping("mypage")
public class MypageContorller {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("list")
	public void mypageList(String userId, Model model){
		
		MemberDto memberInfoByUserId =  (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		System.out.println("멤버인포 :"+memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
		
		MemberDto myInfo = (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		model.addAttribute("myInfo", myInfo);
		System.out.println(myInfo);
		
		Map<String, Integer> countActivity = (Map<String, Integer>) memberService.selectMemberInfoByUserId(userId).get(1);
		model.addAttribute("countActivity", countActivity);
		System.out.println(countActivity);
		
	}
	@PostMapping("list")
	public void mypagelistFormSubmit(String userId) {
		//form post로 무엇을 할까 ?
	}
	
	
	
	@GetMapping({"get", "modify"})
	public void myGetAndModify(@RequestParam(name="userId") String userId, Model model){
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId =  (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		System.out.println("멤버인포 :"+memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
	}
	
	@GetMapping(value ="{userId}/profileImg", produces = MediaType.IMAGE_JPEG_VALUE)
	public ResponseEntity<byte[]> myGetAndModifyWithProFile(@PathVariable(name="userId") String userId) throws Exception {
		
		
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId = (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		
		//프로필 이미지 보이기

		InputStream imageStream = new FileInputStream("user_profile/" + userId + "/" + memberInfoByUserId.getProfileImg());
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		

		System.out.println("이미지 "+imageByteArray);
		return new ResponseEntity<byte[]>(imageByteArray, HttpStatus.OK);
		
	}
	
	//회원정보 수정
	@PostMapping("modify")
	public String memberInfoModify(MemberDto memberModifiedValues, @RequestParam("file") MultipartFile File) {
		//수정은 DB 삭제하고 -> 새로 저장 하기.
		
		memberService.updateMemberInfoByUserId(memberModifiedValues, File);
		//memberService.deleteMemberInfoByUserId(userId);
		//memberService.insertMember(memberModifiedValues);
		
		// member/get?userId=아이디 : 페이지로 이동하기.
		return "redirect:/mypage/get?userId="+memberModifiedValues.getUserId() ; 
	}
	@PostMapping("delete")
	public String deleteMemberInfo(String userId) {
		// 작성 예정 입니다... form ->post방식으로 히든input name ="userId" 응용 합니다.
		
		memberService.deleteMemberInfoByUserId(userId);
		
		return "redirect:/main/list";
	}
	
	@GetMapping("myAbDocumentList")
	public void getMyAbDocumnetList(@RequestParam("userId") String userId, @RequestParam(name= "page", defaultValue = "1") int page,  MemberPageInfo pageInfo, Model model) {

		MemberDto AbdoucumentListByUserId = memberService.getUserAbList(userId,page,pageInfo);
		System.out.println("아카데미 게시판에 작성한 글 리스트: " + AbdoucumentListByUserId);
		
		model.addAttribute("list", AbdoucumentListByUserId);
		model.addAttribute("pageInfo", pageInfo);
	}
	
	@GetMapping("myFbDocumentList")
	public void getMyFbDocumnetList(@RequestParam("userId") String userId, @RequestParam(name= "page", defaultValue = "1") int page,  MemberPageInfo pageInfo, Model model) {

		MemberDto FbdoucumentListByUserId = memberService.getUserFbList(userId,page,pageInfo);
		System.out.println("자유 게시판에 작성한 글 리스트: " + FbdoucumentListByUserId);

		model.addAttribute("list", FbdoucumentListByUserId);
		model.addAttribute("pageInfo", pageInfo);
	}
	
	@GetMapping("myMainDocumentList")
	public void getMyMainDocumnetList(@RequestParam("userId") String userId, @RequestParam(name= "page", defaultValue = "1") int page,  MemberPageInfo pageInfo, Model model) {

		MemberDto MaindoucumentListByUserId = memberService.getUserMainList(userId,page,pageInfo);
		System.out.println("메인에 작성한 글 리스트: " + MaindoucumentListByUserId);

		model.addAttribute("list", MaindoucumentListByUserId);
		model.addAttribute("pageInfo", pageInfo);
	}
	
	
	@GetMapping("myReplyList")
	public void getMyReplyList(@RequestParam("userId") String userId, Model model) {
		
		List<MemberDto> ReplylistByUserId = memberService.getUserReplyList(userId);
		System.out.println("작성한 댓글리스트 : " + ReplylistByUserId);
		
		//List<MemberDto>라 아래와 같이 분리해서 함... 분리 안하면 jsp에서 못찾음. 분리 안하고 하는 방법은 없는지...?
		
		String userId1 = ReplylistByUserId.get(0).getUserId();
		
		List<AcademyReplyDto> AbReply = ReplylistByUserId.get(0).getUserAbReplyList();
		
		System.out.println(AbReply);
		List<FreeReplyDto> FbReply = ReplylistByUserId.get(1).getUserFbReplyList();
		
		System.out.println(FbReply);
		
		List<ReplyDto> MainReply = ReplylistByUserId.get(2).getUserMainReplyList();
		
		Map<String, Integer> countActivity = (Map<String, Integer>) memberService.selectMemberInfoByUserId(userId).get(1);
		
		model.addAttribute("userId", userId1);
		model.addAttribute("userAbReplyList", AbReply);
		model.addAttribute("userFbReplyList", FbReply);
		model.addAttribute("userMainReplyList",MainReply);
		model.addAttribute("countActivity", countActivity);
		
	}
	
	@GetMapping("myLikeList")
	public void getMyLikeList(@RequestParam("userId") String userId, Model model) {
		List<MemberDto> LikelistByUserId = memberService.getUserLikeList(userId);
		System.out.println("좋아요한 글 리스트: " + LikelistByUserId);
		
		String userId2 = LikelistByUserId.get(0).getUserId();
		List<BoardDto> AbLike = LikelistByUserId.get(0).getUserAbLikeList();
		List<com.footsalhaja.domain.free.BoardDto> FbLike = LikelistByUserId.get(1).getUserFbLikeList();
		
		Map<String, Integer> countActivity = (Map<String, Integer>) memberService.selectMemberInfoByUserId(userId).get(1);
		
		model.addAttribute("userId", userId2);
		model.addAttribute("userFbLikeList", FbLike);
		model.addAttribute("usrAbLikeList", AbLike);
		model.addAttribute("countActivity", countActivity);
	}
	
}
