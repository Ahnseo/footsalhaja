package com.footsalhaja.mapper.qna;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;

@Mapper
public interface QnAMapper {

	//Create QnABoard
	int insertQnABoard(QnADto qnaBoard);
	
	//select myQnA TABLE by userId
	List<QnADto> myQnAList(String userId);

	QnADto selectMyQnAListByUserId(String userId);
	
	//select all FAQ TABLE
	List<FAQDto> selectFAQList();
	
}
