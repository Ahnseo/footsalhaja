package com.footsalhaja.controller.academy;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;


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
import com.google.gson.Gson;

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
	
	
	/*
	  @PostMapping(value="/uploadSummernoteImageFile", produces ="application/json")
	  
	  @ResponseBody public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
	  
	  JsonObject jsonObject = new JsonObject();
	  
	  String fileRoot = "C:\\summernote_image\\"; //저장될 외부 파일 경로 String
	  String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명 String
	  String extension = originalFileName.substring(originalFileName.lastIndexOf("."));//파일 확장자
	  
	  String savedFileName = UUID.randomUUID() + extension; //저장될 파일 명
	  
	  File targetFile = new File(fileRoot + savedFileName);
	  
	  try {
		  InputStream fileStream = multipartFile.getInputStream();
		  FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
		  jsonObject.addProperty("url", "/summernoteImage/" + savedFileName);
		  jsonObject.addProperty("responseCode", "success");
	  
	  } catch (IOException e) {
		  FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
		  jsonObject.addProperty("responseCode", "error"); e.printStackTrace();
	  }
	  
	  return jsonObject;
	  }
	 
	 */
	
	
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
