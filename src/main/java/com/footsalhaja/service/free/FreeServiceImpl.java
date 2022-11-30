package com.footsalhaja.service.free;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.mapper.free.FreeMapper;

@Service
public class FreeServiceImpl implements FreeService{
	
	@Autowired
	private FreeMapper mapper;
	
	
	@Override
	public int insert(BoardDto board) {
		return mapper.insert(board);
	}


	@Override
	public List<BoardDto> listBoard() {
		return mapper.list();
	}
	 
	@Override
	public BoardDto get(int fb_number) {
		return mapper.select(fb_number);
	}
	 
	@Override
	public int update(BoardDto board) {
		return mapper.update(board);
	}
	
	@Override
	public int remove(int fb_number) {
		return mapper.delete(fb_number);
	}
	
	
	
}
