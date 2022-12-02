package com.footsalhaja.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.member.MemberService;

@Controller
@RequestMapping("mypage")
public class MypageContorller {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("list")
	public void mypageList(String userId, Model model){
		// list에서 기본 정보를 히든 input으로 넣어둘까 ?
		MemberDto myInfo = memberService.selectMemberInfoByUserId(userId);
		model.addAttribute("myInfo", myInfo);
		
	}
	@PostMapping("list")
	public void mypagelistFormSubmit(String userId) {
		//form post로 무엇을 할까 ?
	}
	
	@GetMapping({"get", "modify"})
	public void myGetAndModify(@RequestParam(name="userId") String userId, Model model){
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);
		MemberDto memberInfoByUserId = memberService.selectMemberInfoByUserId(userId);
		System.out.println(memberInfoByUserId);
		model.addAttribute("member", memberInfoByUserId);
		
	}
	
	//회원정보 수정
	@PostMapping("modify")
	public String memberInfoModify(MemberDto memberModifiedValues) {
		//수정은 DB 삭제하고 -> 새로 저장 하기.
		
		memberService.updateMemberInfoByUserId(memberModifiedValues);
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
}
