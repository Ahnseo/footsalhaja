package com.footsalhaja.service.main;

import com.footsalhaja.domain.main.MainDto;

public interface MainService {
	
	public MainDto get(int bookId);

	public int insert(MainDto mainBoard);
	

	public MainDto get(int bookId);

	public void getById(int id);

}
