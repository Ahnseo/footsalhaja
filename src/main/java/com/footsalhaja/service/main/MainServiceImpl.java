package com.footsalhaja.service.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.domain.main.PageInfo;
import com.footsalhaja.mapper.main.MainMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mapper;
	
	
	@Override
	public int insert(MainDto mainBoard) {
		System.out.println("테스트");
		
		return mapper.insert(mainBoard);
	}

	public List<MainDto> mainList(int page, String type, String keyword, PageInfo pageInfo) {
		int records = 10;
		int offset = (page - 1) * records;
		
		
		return mapper.list(offset, records, type, "%" + keyword +"%");
	}

	@Override
	public MainDto get(int bookId) {
		return mapper.getById(bookId);

	}
	
	public int update(MainDto main) {
		return mapper.update(main);
	}

}
