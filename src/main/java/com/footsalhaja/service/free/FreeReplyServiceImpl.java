package com.footsalhaja.service.free;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.free.FreeReplyDto;
import com.footsalhaja.mapper.free.FreeReplyMapper;

@Service
public class FreeReplyServiceImpl implements FreeReplyService {
	
	@Autowired
	FreeReplyMapper mapper;
	

	@Override
	public int addReply(FreeReplyDto reply) {
		return mapper.insert(reply);
	}
	
	@Override
	public List<FreeReplyDto> listReplyByBoardId(int freeBoard_fb_number, String username){
		return mapper.listReplyByBoardId(freeBoard_fb_number, username);
	}
	
	@Override
	public int deleteById(int fb_replyNumber) {
		return mapper.deleteById(fb_replyNumber);
	}
	
	@Override
	public FreeReplyDto getById(int fb_replyNumber) {
		return mapper.getById(fb_replyNumber);
	}
	
	@Override
	public int modify(FreeReplyDto reply) {
		return mapper.update(reply);
	}
	


}
