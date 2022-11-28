package com.footsalhaja.service.qna;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.mapper.qna.QnAMapper;

@Service
public class QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
	
}
