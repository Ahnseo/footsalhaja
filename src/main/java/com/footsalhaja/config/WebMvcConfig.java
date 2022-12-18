package com.footsalhaja.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	// web root가 아닌 외부 경로에 있는 리소스를 url로 불러올 수 있도록 설정
	// 현재 localhost:8090/summernoteImage/1234.jpg
	// 로 접속하면 /C:/Users/lnh1017/Desktop/study/project//1234.jpg 파일을 불러온다.
	/*
	 * @Override public void addResourceHandlers(ResourceHandlerRegistry registry) {
	 * registry.addResourceHandler("/summernoteImage/**") .addResourceLocations(
	 * "file:///C://Users//lnh1017//Desktop//study//project//footsalhaja//sn_img/");
	 * .addResourceLocations("s3://study-2022-08-02-lnh-2023-02-09/academy/"); }
	 */
}
