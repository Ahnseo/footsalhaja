package com.footsalhaja.mapper.qna;

import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.QnADto;

@Mapper
public interface QnAMapper {
	
	//Create QnABoard
	void insertQnABoard(QnADto qnaBoard);
	
	
}
