package com.footsalhaja.config;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

@Configuration
@MapperScan("com.footsalhaja.mapper")
@EnableGlobalMethodSecurity(prePostEnabled = true) // 컨트롤러에서 메소드들에게 @preAuthorize() 사용하기위해 
public class CustomConfig {
	
	// WEB-INF/props/aws.properties 파일 속의  id, key(비번) 매칭하기
	@Value("${aws.accessKeyId}") //import org.springframework.beans.factory.annotation.Value;
	private String accessKeyId;
	
	@Value("${aws.secretAccessKey}") //import org.springframework.beans.factory.annotation.Value;
	private String secretAccessKey;
	
	
	@Value("${aws.s3.file.url.prefix}")
	private String imgUrl;
	
	@Autowired
	private ServletContext servletContext;
	
	@PostConstruct
	public void init() {
		servletContext.setAttribute("imgUrl", imgUrl);
	}
	
	@Bean
	public AwsCredentials awsCredentials() {
		return AwsBasicCredentials.create(accessKeyId, secretAccessKey);
	}
	
	@Bean
	public AwsCredentialsProvider awsCredentialsProvider() {
		return StaticCredentialsProvider.create(  awsCredentials()  );
	}
	
	@Bean
	public S3Client s3Client() {
		//spring 에서 aws s3 객체로 put/ delete 메소드를 사용하기 위해
		return  S3Client.builder()
				.credentialsProvider(  awsCredentialsProvider()  ) //자격증명 메소드	
				.region(Region.AP_NORTHEAST_2).build();
	}
	
	// 로그인 성공 실패 
	@Bean
	public org.springframework.security.web.SecurityFilterChain SecurityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests().antMatchers("/css/**", "/js/**", "/images/**").permitAll();
		http.formLogin().loginPage("/member/login").defaultSuccessUrl("/main/list", true);// 로그인 성공하면  메인 리스트로. 
		http.logout().logoutUrl("/member/logout").logoutSuccessUrl("/main/list");
		http.csrf().disable(); // 원래는 이러면 안됌, 모든 페이지에 csrf공격 보안적용을 해제중!!!!!!  
		http.rememberMe(); // 브라우저를 닫아도 쿠키를 저장 시킴 
		
		return http.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		//security 암호화된 패스워드를 비교
		return new BCryptPasswordEncoder();
	}
	
}







