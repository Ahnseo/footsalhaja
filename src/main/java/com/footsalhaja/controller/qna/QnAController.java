package com.footsalhaja.controller.qna;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.qna.FAQDto;
import com.footsalhaja.domain.qna.QnADto;
import com.footsalhaja.domain.qna.QnAPageInfo;
import com.footsalhaja.domain.qna.QnAReplyDto;
import com.footsalhaja.domain.qna.QnAReplyToAnswerDto;
import com.footsalhaja.service.qna.QnAService;



@Controller
@RequestMapping("qna")
public class QnAController {
	
	@Autowired
	private QnAService qnaService;

	// main
	@GetMapping("qnaMainBoard")
	public void qnaMainBoard(@RequestParam(name="page", defaultValue = "1") int page,
							@RequestParam(name="q") String keyword,
							@RequestParam(name="t") String type,
							@RequestParam(name="c") String c,
							QnAPageInfo qnaPageInfo,
							Model model
							) {
		// FAQ data 가져오기
		List<FAQDto> FAQList = qnaService.selectFAQList();
		// 답변완료된!! allQnAList 만!! 가져오기
		//System.out.println("@@@@ c :"+c);
		List<QnADto> allQnAListByDone = qnaService.selectQnAListByStatusDone(page, qnaPageInfo, type, keyword, c);
		
		
		
		model.addAttribute("FAQList", FAQList);
		model.addAttribute("allQnAListByDone", allQnAListByDone);
		model.addAttribute("qnaPageInfo", qnaPageInfo);
	}

	// insert
	@GetMapping("insert")
	public void insertPageOpen() {

	}

	@PostMapping("insert")
	public String insertQnA(QnADto qnaBoard, String userId, MultipartFile[] files) {
		
		qnaService.insertQnABoard(qnaBoard, files); // null : ServiceImpl 에서만 model 사용중이기 때문

		return "redirect:/qna/myQnAList?userId="+userId+"&page=1&t=all&q=&c=";
	}

	// MyQnAList
	@GetMapping("myQnAList")
	public void myQnAList(@RequestParam(name = "page", defaultValue = "1") int page,
							@RequestParam(name = "t", defaultValue = "all")	String type,
							@RequestParam(name = "q") String keyword,	
							@RequestParam(name = "c") String c,
							QnAPageInfo qnaPageInfo,
							Model model, String userId) throws Exception {
		// myQnAList 페이지네이션 추가
		List<QnADto> myQnAList = new ArrayList<>();
		myQnAList = qnaService.myQnAList(userId, page, qnaPageInfo, type, keyword, c );
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

		//System.out.println("qna 정보 : "+ qna);
		model.addAttribute("qna", qna);
		
		QnAReplyDto qnaAnswer = qnaService.selectQnAReply(qnaReply);
		//System.out.println("qnaAnswer :"+qnaAnswer);
		
		model.addAttribute("qnaAnswer", qnaAnswer);
		
		int qnaReplyId = qna.getQnaReplyId();
		
		List<QnAReplyToAnswerDto> qnaReplyToAnswerList = qnaService.selectQnAReplyToAnswerList(qnaReplyId);
		
		
		model.addAttribute("qnaReplyToAnswerList", qnaReplyToAnswerList);
	}
	
	// myQnA게시물 . 저장한 정보 내용 또는 수정된 최신 내용 가저오기  
	@GetMapping("myQnAModify")
	public void myQnAModify( String userId, int qnaId, Model model) {
		
		QnADto qna = qnaService.selectMyQnAGetByQnAIdAndUserId(userId, qnaId);
		
		model.addAttribute("qna", qna);
	}
	// myQnA게시물 수정하기 !
	@PostMapping("myQnAModify")
	public String updateQnAInfo(@RequestParam(name="removeFiles", required = false) List<String> removeFiles, 
								@RequestParam(name="files") MultipartFile[] addFiles,
								QnADto modifiedQnA) {
		//파일 삭제 기능 추가 
		System.out.println("removeFiles :::"+removeFiles);
		System.out.println("addFiles ###"+addFiles);
		
		//업데이트 하고,select 해서 model에 넣고 -> 페이지 이동 해서 보여주기 
		qnaService.updateMyQnABoard(modifiedQnA, removeFiles, addFiles);
		
		return "redirect:/qna/myQnAGet?userId="+modifiedQnA.getUserId()+"&qnaId="+modifiedQnA.getQnaId();
	}
	
	@DeleteMapping("deleteMyQnA")
	@ResponseBody
	public String deleteQnA(@RequestBody QnADto qna, HttpServletRequest request) {
		int qnaId = qna.getQnaId();
		//System.out.println(qnaId);
		qnaService.deleteQnA(qnaId);
		
		return "/qna/myQnAList?userId="+qna.getUserId()+"&page=1&c=&t=all&q=";
		
		
	}
	
	
	@PutMapping("likeCount")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public Map<String, Object>  updatelikeCount(@RequestBody Map<String, String> req, Authentication authentication, HttpServletRequest request) {
		String qnaId = req.get("qnaId");
		String loggedinId = authentication.getName();		
		
		//클릭하면 저장, 다시클릭하면 삭제되는 좋아요 DB
		Map<String, Object> result = qnaService.updateLikeCount(qnaId, loggedinId);
		
		// json형태로 map.put 으로 넣은 liked? not liked?-> current ,좋아요 총갯수 count  
		return result;
		
	}
	
	
	
	
}




