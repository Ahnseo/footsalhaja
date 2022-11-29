package com.footsalhaja.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.mapper.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	
	@Override
	public MainDto get(int bookId) {
		
		return null;
		
	}
	
	@Override
	public int insert(MainDto mainBoard) {
		System.out.println("테스트");
		
		return mapper.insert(mainBoard);
	}
}
