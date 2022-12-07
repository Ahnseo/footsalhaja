package com.footsalhaja.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.service.main.ReplyServiceImpl;
import com.footsalhaja.service.member.MemberServiceImpl;

@Controller
@RequestMapping("mainReply")
public class ReplyController {
	
	@Autowired
	private ReplyServiceImpl replyService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@PostMapping("add")
	@ResponseBody
	public Map<String, Object> add(@RequestBody ReplyDto reply) {		
		
		Map<String, Object> map = new HashMap<>();
	
		replyService.addReply(reply);

		return map;
	}
	
	@GetMapping("list/{bookId}")
	@ResponseBody
	public List<ReplyDto> list(@PathVariable int bookId){
		return replyService.listReplyByBookId(bookId);
	}
	
	@DeleteMapping("remove/{replyId}")
	public void remove(@PathVariable int replyId) {
		replyService.removeById(replyId);
		
	}
	
	@GetMapping("get/{replyId}")
	@ResponseBody
	public ReplyDto get(@PathVariable int replyId) {
		return replyService.getByReplyId(replyId);
		
	}
	
	/*
	 * @GetMapping("add")
	 * 
	 * @ResponseBody public void add(@RequestParam(name="userId") String userId,
	 * Model model) { MemberDto member =
	 * memberService.selectMemberInfoByUserId(userId); model.addAttribute("member",
	 * member);
	 * 
	 * }
	 */
				
}
