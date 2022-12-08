package com.footsalhaja.controller.qna;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.service.qna.QnAService;

@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired
	private QnAService qnaService;

	// main
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard(Model model) {
		// FAQ data 가져오기
		List<FAQDto> FAQList = qnaService.selectFAQList();
		// System.out.println(FAQList);

		model.addAttribute("FAQList", FAQList);
	}

	// insert
	@GetMapping("insert")
	public void insertPageOpen() {

	}

	@PostMapping("insert")
	public String insertQnA(QnADto qnaBoard, String userId) {

		qnaService.insertQnABoard(qnaBoard); // null : ServiceImpl 에서만 model 사용중이기 때문

		return "redirect:/qna/myQnAList?userId=" + userId;
	}

	// MyQnAList
	@GetMapping("myQnAList")
	public void myQnAList(@RequestParam(name = "page", defaultValue = "1") int page, QnAPageInfo qnaPageInfo,
			Model model, String userId) {
		// myQnAList 페이지네이션 추가
		List<QnADto> myQnAList = new ArrayList<>();
		myQnAList = qnaService.myQnAList(userId, page, qnaPageInfo);
		model.addAttribute("myQnAList", myQnAList);

		// 게시판 내림차순 만들기 위해 사용 myQnAListSize - st.count
		int myQnAListSize = myQnAList.size();
		model.addAttribute("myQnAListSize", myQnAListSize);

		model.addAttribute("qnaPageInfo", qnaPageInfo);

	}

	// MyQnAGet
	@GetMapping("myQnAGet")
	public void myQnAGet(String userId, int qnaId, Model model, QnAReplyDto qnaReply) {
		QnADto qna = qnaService.selectMyQnAGetByQnAIdAndUserId(userId, qnaId);
		//System.out.println(qna);
		model.addAttribute("qna", qna);
		
		List<QnAReplyDto> qnaReplyList = qnaService.selectQnAReply(qnaReply);
		model.addAttribute("qnaReplyList", qnaReplyList);
		
		
	}
	@PutMapping("likeCount")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	private Map<String, String> insertlikeCount(@RequestBody Map<String, String> req, Authentication authentication) {
		String qnaId = req.get("qnaId");
		String loggedinId = authentication.getName();
		
		System.out.println("qnaId : " + qnaId );
		System.out.println("loggedinId : " + loggedinId);
		
		//클릭하면 저장, 다시클릭하면 삭제되는 좋아요 DB	
		return qnaService.updateLikeCount(qnaId, loggedinId);
	}
	
	
	
	
}




