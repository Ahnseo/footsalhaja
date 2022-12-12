package com.footsalhaja.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.main.MainDto;
import com.footsalhaja.mapper.main.MainMapper;

@Component
public class MainSecurity {
	@Autowired
	private MainMapper mainMapper;
	
	// 메인 게시물 권한 체크
	// 로그인된 아이디랑 작성자 아이디 같아야만 수정 가능
	public boolean checkWriter(String username, int bookId) {
		MainDto main = mainMapper.getById(bookId);
		
		return main.getUserId().equals(username);
				
				//getMember_userId().equals(username);
		
	}
}
