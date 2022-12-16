package com.footsalhaja.service.main;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.main.MainDto;

public interface MainService {
	
	public MainDto get(int bookId);

	public int insert(MainDto book);
	
	public int update(MainDto main);


	public List<BookDto> listBook(String datepickerSday, String datepickerEday);

	
	public int remove(int bookId);



}
