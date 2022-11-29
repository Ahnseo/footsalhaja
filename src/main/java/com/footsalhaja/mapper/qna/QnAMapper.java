package com.footsalhaja.mapper.qna;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnAMapper {
	
<<<<<<< Updated upstream
=======
	//Create QnABoard
	int insertQnABoard(QnADto qnaBoard);

	List <QnADto> selectQnABoardAll();

	List <QnADto> selectMyQnAListByUserId(String userId);
	
>>>>>>> Stashed changes
	
}
