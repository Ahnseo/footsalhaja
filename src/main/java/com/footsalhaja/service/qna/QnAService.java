package com.footsalhaja.service.qna;

<<<<<<< Updated upstream
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
=======
import java.util.List;

import org.springframework.ui.Model;

import com.footsalhaja.domain.qna.QnADto;
>>>>>>> Stashed changes

import com.footsalhaja.mapper.qna.QnAMapper;

<<<<<<< Updated upstream
@Service
public class QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
=======
	public int insertQnABoard(QnADto qnaBoard, Model model);
	
	public List <QnADto> selectQnABoardAll();
	
	public List <QnADto> selectMyQnAListByUserId(String userId);
>>>>>>> Stashed changes
	
}
