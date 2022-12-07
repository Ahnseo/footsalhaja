package com.footsalhaja.controller.academy;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.domain.academy.PageDto;
import com.footsalhaja.service.academy.AcademyServiceImpl;




@Controller
@RequestMapping("academy")
public class AcademyController {
	
	@Autowired
	private AcademyServiceImpl service;

	

	
	//list 목록
	@GetMapping("list")
	public void list(Criteria cri, Model model) {

	
		// request param
		// business logic

		String keyword = cri.getKeyword();
		cri.setKeyword("%"+cri.getKeyword()+"%");

		List<BoardDto> list = service.listBord(cri);
		
		// add attribute
		model.addAttribute("boardList", list);
		
		//전체 데이터의 수 구해서 페이지네이션
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDto(cri, total));
		// forward

		
		cri.setKeyword(keyword);
		

	}
	
	//register 등록
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(BoardDto board) {


		service.insert(board);
				
		return "redirect:/academy/list";
	}
	
	

	  @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	  
	  @ResponseBody public HashMap<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
	  
	  HashMap<String, String> jsonObject = new HashMap<>();
	  
	  
	  String ab_filePath = "C:\\Users\\lnh1017\\Desktop\\study\\project\\"; //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  
	  String ab_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
	  
	  File targetFile = new File(ab_filePath + ab_fileName);
	  
	  System.out.println(targetFile);
	  
	  try {
		  InputStream fileStream = multipartFile.getInputStream();
		  FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
		  jsonObject.put("url", "/summernoteImage/" + ab_fileName);
		  jsonObject.put("ab_fileName", ab_fileName);
		  jsonObject.put("responseCode", "success");
	  
	  } catch (IOException e) {
		  System.out.println(targetFile);
		  
		  FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
		  jsonObject.put("responseCode", "error"); e.printStackTrace();
	  }
	  
	  return jsonObject;
	  }
	  

	

	//get 게시글
	@GetMapping("get")
	public void get (@RequestParam("ab_number") int ab_number, Model model, @ModelAttribute("cri") Criteria cri) {
		
		BoardDto board = service.get(ab_number);
		
		model.addAttribute("board",board);
		
	}
	
	//modify 게시글
	@GetMapping("modify")
	public void modify(int ab_number, Model model) {
		BoardDto board = service.get(ab_number);
		model.addAttribute("board",board);
	}
	
	@PostMapping("modify")
	public String modify(BoardDto board ) {
		service.modify(board);
		
		return "redirect:/academy/list";
	}
	
	//remove 게시글
	@PostMapping("remove") 
	public String remove(int ab_number) {
		service.remove(ab_number);
		
		return "redirect:/academy/list";
	}
	
	
}
