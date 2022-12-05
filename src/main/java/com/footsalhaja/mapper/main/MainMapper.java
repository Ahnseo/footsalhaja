package com.footsalhaja.mapper.main;

import java.util.List;

import com.footsalhaja.domain.main.MainDto;

public interface MainMapper {

	int insert(MainDto id);
	
	List<MainDto> list(int offset, int records, String type, String keyword);

	MainDto getById(int bookId);

	int update(MainDto main);


	int delete(int bookId);

	
}
