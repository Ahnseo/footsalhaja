package com.footsalhaja.service.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.mapper.qna.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
	//Create QnABoard
	@Override
	public void insertQnADto(QnADto qnaBoard) {
		qnaMapper.insertQnABoard(qnaBoard);
		
	}
	
	
}
