package com.footsalhaja.service.main;

import com.footsalhaja.domain.main.MainDto;

public interface MainService {
	// public void register()
	

	public MainDto get(int bookId);

	public void getById(int id);

}
