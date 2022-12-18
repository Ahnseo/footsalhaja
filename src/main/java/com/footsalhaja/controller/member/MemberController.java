package com.footsalhaja.controller.member;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.member.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("existId/{userId}")
	@ResponseBody
	public Map<String, Object> existId(@PathVariable String userId) {
		Map<String, Object> map = new HashMap<>();

		MemberDto member = memberService.getById(userId);

		if (member == null) {
			map.put("status", "not exist");
			map.put("message", "사용가능한 아이디입니다.");
		} else {
			map.put("status", "exist");
			map.put("message", "이미 존재하는 아이디입니다.");
		}

		return map;
	}

	@GetMapping("existNickName/{nickName}")
	@ResponseBody
	public Map<String, Object> existNickName(@PathVariable String nickName) {
		Map<String, Object> map = new HashMap<>();

		MemberDto member = memberService.getByNickName(nickName);

		if (member == null) {
			map.put("status", "not exist");
			map.put("message", "사용가능한 별명입니다.");
		} else {
			map.put("status", "exist");
			map.put("message", "이미 존재하는 별명입니다.");
		}

		return map;
	}
	
	@PostMapping("existEmail")
	@ResponseBody
	public Map<String, Object> existEmail(@RequestBody Map<String, String> req) {

		Map<String, Object> map = new HashMap<>();

		MemberDto member = memberService.getByEmail(req.get("email"));

		if (member == null) {
			map.put("status", "not exist");
			map.put("message", "사용가능한 이메일입니다.");
		} else {
			map.put("status", "exist");
			map.put("message", "이미 존재하는 이메일입니다.");
		}

		return map;
	}
	
	
	@GetMapping("login")
	public void login() {
		// 이대로 void forward 사용.  
	}
	
	@GetMapping("insert")
	public void registerGetMapping(){
		//register.jsp  페이지 이동하기 위한 메소드 
	}
	@PostMapping("insert")
	public String registerPostMapping(MemberDto member){
		//회원가입 
		int cnt = memberService.insertMember(member);
		return "redirect:/main/list"; // 등록하고 -> /main/list.jsp 로 이동  
	}
	
	@GetMapping("get")
	public void getAndModify(@RequestParam(name="userId") String userId, Model model){
		//RequestParam 으로 member/get?userId= 아이디값 가져와서 db 요청 -> MemberDto 타입 member ->  addAttribute "member" 넣음 . 
		//System.out.println(userId);

		MemberDto memberInfoByUserId = (MemberDto) memberService.selectMemberInfoByUserId(userId).get(0);
		System.out.println(memberInfoByUserId);

		model.addAttribute("member", memberInfoByUserId);
		
	}
	


	@PostMapping("addAuth")
	public String addAuth(String userId, MemberDto modifiedMemberInfo) {
		System.out.println("userId????:"+userId);
		List<String> addAuthorities = new ArrayList<>();
		
		List<String> authorities = modifiedMemberInfo.getAuth();
		for(String auth : authorities ) {
			addAuthorities.add(auth);
		}
		
		memberService.updateMemberAuth(userId, addAuthorities);
		return "redirect:/member/get?userId="+userId;
	}

	//회원정보 수정
	@PostMapping("modify")
	public String memberInfoModify(MemberDto memberModifiedValues, @RequestParam("file") MultipartFile File) {
		//수정은 DB 삭제하고 -> 새로 저장 하기.
		
		memberService.updateMemberInfoByUserId(memberModifiedValues, File);
		//memberService.deleteMemberInfoByUserId(userId);
		//memberService.insertMember(memberModifiedValues);

		return "redirect:/member/get?userId="+memberModifiedValues.getUserId();
	}

}
