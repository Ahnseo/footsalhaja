package com.footsalhaja.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.mapper.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	public int get(int id) {
		mapper.insert(id);
		
	}
	// mapper override
}
