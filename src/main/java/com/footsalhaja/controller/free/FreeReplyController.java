package com.footsalhaja.controller.free;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.service.free.FreeReplyService;

@Controller
@RequestMapping("freeReply")
public class FreeReplyController {
	
	@Autowired
	private FreeReplyService service;
	
	
	@PostMapping("add")
	@ResponseBody
	@PreAuthorize("isAuthenticated()") // 로그인 여부
	public Map<String, Object> add(@RequestBody FreeReplyDto reply, Authentication auth) { // Authentication -> 로그인한 정보 들어있음
		
		reply.setMember_userId(auth.getName());
		
		Map<String, Object> map = new HashMap<>();
		
		int cnt = service.addReply(reply);
		if (cnt == 1) {
			map.put("message", "새 댓글 등록완료");
		}else {
			map.put("message", "새 댓글 등록되지 않음");
		}
		
		return map;
	}
	
	@GetMapping("list/{freeBoard_fb_number}")
	@ResponseBody
	public List<FreeReplyDto> list(@PathVariable int freeBoard_fb_number, Authentication auth) {
		String username = "";
		
		// 로그인 상태면
		if(auth != null) {
			username = auth.getName(); // 로그인한 아이디 얻어오기
		}
		
		return service.listReplyByBoardId(freeBoard_fb_number, username);
	}
	
	@DeleteMapping("delete/{fb_replyNumber}")
	@ResponseBody
	@PreAuthorize("@replySecurity.checkWriter(authentication.name, #fb_replyNumber)")
	public Map<String, Object> delete(@PathVariable int fb_replyNumber) {
		int cnt = service.deleteById(fb_replyNumber);
		
		Map<String, Object> map = new HashMap<>();
		if (cnt == 1) {
			map.put("message", "새 댓글 삭제완료");
		} else {
			map.put("message", "새 댓글 삭제되지 않음");
		}
		
		return map;
	}
	
	@GetMapping("get/{fb_replyNumber}")
	@ResponseBody
	public FreeReplyDto get(@PathVariable int fb_replyNumber) {
		
		return service.getById(fb_replyNumber); 
	}
	
	@PutMapping("modify")
	@ResponseBody									// @은 외부 빈, #은 메소드의 파라미터
	@PreAuthorize("@replySecurity.checkWriter(authentication.name, #reply.fb_replyNumber)")
	public Map<String, Object> modify(@RequestBody FreeReplyDto reply) {
		Map<String, Object> map = new HashMap<>();
		
		int cnt = service.modify(reply);
		 
		if (cnt == 1) {
			map.put("message", "댓글 수정완료");
		} else {
			map.put("message", "댓글 수정되지 않음");
		}
		
		return map;
	}	
	
	
	
	
	
}
