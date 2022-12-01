package com.footsalhaja.mapper.main;


import java.util.List;
import com.footsalhaja.domain.main.MainDto;

public interface MainMapper {

	int insert(MainDto id);
	int getById(int id);
	List<MainDto> list(int offset, int records, String type, String keyword);

	MainDto getById(int bookId);


}
