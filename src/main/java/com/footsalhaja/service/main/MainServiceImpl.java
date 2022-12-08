package com.footsalhaja.service.main;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.main.BookDto;
import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.mapper.main.MainMapper;
import com.footsalhaja.mapper.main.ReplyMapper;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper bookMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public int insert(MainDto book) {
		System.out.println("테스트");
		LocalDateTime date  = LocalDateTime.now();
		// spring security에서 정보 가져오기
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		UserDetails userDetails = (UserDetails)principal; 
		String username = userDetails.getUsername();
		String nickname =  bookMapper.selectNick(username);
		// 작성시간을 book에 넣음
		book.setInsertDatetime(date);
		// 로그인한 ID를 book에 넣음 (Security에 있는 로그인한 Id)
		book.setUserId(username);
		book.setNickName(nickname);
		System.out.println("book2 : "  + book);
		return bookMapper.insert(book);
	}


	@Override
	public MainDto get(int bookId) {
		return bookMapper.getById(bookId);

	}
	
	public int update(MainDto main) {
		return bookMapper.update(main);
	}



	//@Override
	// 메인리스트 불러오기
	public List<BookDto> listBook() {
		return bookMapper.listBook();
	}

	public int remove(int bookId) {
		
		replyMapper.deleteByBookId(bookId);
		
		return bookMapper.delete(bookId);
		
	}

}
