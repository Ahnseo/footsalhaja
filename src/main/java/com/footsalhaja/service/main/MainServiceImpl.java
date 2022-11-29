package com.footsalhaja.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.mapper.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;

	// mapper override

	@Override
	public void getById(int id) {
		// TODO Auto-generated method stub
		
	}

}
