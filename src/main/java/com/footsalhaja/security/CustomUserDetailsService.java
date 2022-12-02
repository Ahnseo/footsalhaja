package com.footsalhaja.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.footsalhaja.domain.member.MemberDto;
import com.footsalhaja.mapper.member.MemberMapper;

@Component //빈을 만들기 위해 컴포넌 :  Bean이 되어야 스프링이 알아보고 UserDetailsService 를 사용한다.
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		MemberDto member = memberMapper.selectMemberInfoByUserId(username);
		System.out.println(member);
		if(member == null){
			return null;
		}else {
			
			String encodedPw = passwordEncoder.encode(member.getPassword() );
			
			List < SimpleGrantedAuthority > authorityList = new ArrayList<>(); // -> 권한 정보 테이블 만들어서 넣기 
			
			if (member.getAuth() != null) {
				for (String auth : member.getAuth()) {	
					authorityList.add(new SimpleGrantedAuthority(auth));
				}
			}
			User user = new User(member.getUserId(), encodedPw, List.of() ); //import org.springframework.security.core.userdetails.User;
																	// 세번째 파라미터 : 권한 (authorization), 부장님인지 대리님인지 등등 
			System.out.println(user);
			return user;
			
		}
		
	}
}