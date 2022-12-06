package com.footsalhaja.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.mapper.free.FreeMapper;

@Component //빈을 만들기 위해 컴포넌
public class BoardSecurity {
	
	@Autowired
	private FreeMapper freeMapper;
	
	// 프리보드
	// 로그인된 아이디랑 작성자 아이디 같아야만 수정가능하게
	public boolean checkWriter(String username, int fb_number) {
		BoardDto board = freeMapper.select(fb_number);
		
		return board.getMember_userId().equals(username);
	}
	
	// 아카데미 아이디 확인 메소드는 여기쓰면 좋을거 같아용
	// checkWriter2() 요런식으로 ?
}
