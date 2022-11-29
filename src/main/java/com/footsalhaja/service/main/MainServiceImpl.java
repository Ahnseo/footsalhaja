package com.footsalhaja.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.mapper.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	
	@Override
	public int get(int id) {
		return mapper.selectById(id);
		
	}
	// mapper override
}
