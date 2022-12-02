package com.footsalhaja.controller.academy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.domain.academy.ReplyPageDto;
import com.footsalhaja.service.academy.AcademyReplyService;

@Controller
@RequestMapping("reply")
public class AcademyReplyController {
	@Autowired
	private AcademyReplyService service;
	
	/*
	 * @GetMapping("list/{ab_number}")
	 * 
	 * @ResponseBody public Map<String, Object> list(@PathVariable("ab_number") int
	 * ab_number, Criteria cri ) { System.out.println(ab_number);
	 * 
	 * //service의 replyWithPaging(), listReplyByab_number 두개 다 리턴 Map<String,
	 * Object> map = new HashMap<>();
	 * 
	 * ReplyPageDto replyWithPaging = service.replyWithPaging(cri, ab_number);
	 * 
	 * List<AcademyReplyDto> listReplyByab_number=
	 * service.listReplyByab_number(ab_number);
	 * 
	 * map.put("replyList", listReplyByab_number);
	 * 
	 * map.put("replyPage", replyWithPaging);
	 * 
	 * 
	 * System.out.println(map);
	 * 
	 * return map; }
	 */
	@GetMapping("list/{ab_number}")
	@ResponseBody 
	public List<Object> list(@PathVariable("ab_number") int ab_number, Criteria cri) {
		System.out.println(ab_number);
		
		List<Object> replyList = new ArrayList<>();
		
		ReplyPageDto replyWithPaging = service.replyWithPaging(cri, ab_number);
		
		replyList.add(replyWithPaging);
		System.out.println(replyList);
		return replyList;
		
	}
	 


	@PostMapping("add")
	@ResponseBody
	public Map<String, Object> add(@RequestBody AcademyReplyDto reply) {

		Map<String, Object> map = new HashMap<>();
		
		int cnt = service.addReply(reply);
		
		System.out.println(reply);
		
		if (cnt == 1) {
			map.put("message", "새 댓글이 등록되었습니다.");
		} else {
			map.put("message", "새 댓글이 등록되지 않았습니다.");
		}
		
		return map;
	}
	
	@DeleteMapping("remove/{ab_replyNumber}")
	@ResponseBody
	public Map<String, Object> remove(@PathVariable int ab_replyNumber) {
		Map<String, Object> map = new HashMap<>();
		
		int cnt = service.removeById(ab_replyNumber);
		if (cnt == 1) {
			map.put("message", "댓글이 삭제되었습니다.");
		} else {
			map.put("message", "댓글이 삭제되지 않았습니다.");
		}
		return map;
	}
	
	@GetMapping("get/{ab_replyNumber}")
	@ResponseBody
	public AcademyReplyDto get(@PathVariable int ab_replyNumber) {
		return service.getById(ab_replyNumber);
	}
	
	@PutMapping("modify")
	@ResponseBody
	public Map<String, Object> modify(@RequestBody AcademyReplyDto reply) {
		Map<String, Object> map = new HashMap<>();

		int cnt = service.modify(reply);
		
		
		if (cnt == 1) {
			map.put("message", "댓글이 수정되었습니다.");
		} else {
			map.put("message", "댓글이 수정되지 않았습니다.");
		}
		
		return map;
	}
}
