package com.footsalhaja.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.QnADto;

@Mapper
public interface AdminMapper {

	List<QnADto> selectWatingQnAList(String status);
	
}
