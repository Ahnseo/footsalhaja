package com.footsalhaja.mapper.qna;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.footsalhaja.domain.qna.QnADto;

@Mapper
public interface QnAMapper {

	//Create QnABoard
	int insertQnABoard(QnADto qnaBoard);
	
	//select all QnA
	List<QnADto> list();

	QnADto selectMyQnAListByUserId(String userId);
	
}
