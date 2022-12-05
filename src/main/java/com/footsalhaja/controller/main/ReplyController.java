package com.footsalhaja.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.main.ReplyDto;
import com.footsalhaja.service.main.ReplyServiceImpl;

@Controller
@RequestMapping("reply")
public class ReplyController {
	
	@Autowired
	private ReplyServiceImpl service;
	
	@PostMapping("add")
	@ResponseBody
	public Map<String, Object> add(@RequestBody ReplyDto reply) {		
		Map<String, Object> map = new HashMap<>();
		
		int cnt = service.addReply(reply);
		
		if(cnt == 1 ) {
			map.put("message", "새 댓글이 등록되었습니다.");
		} else {
			map.put("message", "새 댓글이 등록되지 않았습니다.");
		}
		return map;
	}
	
	@GetMapping("list/{bookId}")
	@ResponseBody
	public List<ReplyDto> list(@PathVariable int bookId){
		return service.listReplyByBookId(bookId);
	}
	
	
	
}
