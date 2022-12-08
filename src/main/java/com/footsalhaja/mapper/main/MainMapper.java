package com.footsalhaja.mapper.main;

import java.util.List;

import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.main.MainDto;

public interface MainMapper {

	int insert(MainDto book);
	
	MainDto getById(int bookId);

	int update(MainDto main);


	int delete(int bookId);

	
	String selectNick(String userId) ;

	List<BookDto> listBook();
	
	BookDto select(int bookId, String nickName);

}
 