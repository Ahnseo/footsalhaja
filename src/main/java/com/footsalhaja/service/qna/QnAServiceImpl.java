package com.footsalhaja.service.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.mapper.qna.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper qnaMapper;
	
	//Create QnABoard
	@Override
	public int insertQnABoard(QnADto qnaBoard) {
		//String nickName = memberMapper.selectNickNameByMember();
		//model.addAttribute("memberNickName", nickName); 나중에 로그인 만들어지면 사용할것. 	
		int cnt = qnaMapper.insertQnABoard(qnaBoard);
		return cnt;
	}

	@Override
	public List<QnADto> myQnAList(String userId) {
		return qnaMapper.myQnAList(userId);
	}
	
	@Override
	public QnADto selectMyQnAListByUserId(String userId) {
		return qnaMapper.selectMyQnAListByUserId(userId);
	}
	@Override
	public List<FAQDto> selectFAQList() {
		return qnaMapper.selectFAQList();
	}

	
	
}
