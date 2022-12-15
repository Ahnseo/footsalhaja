package com.footsalhaja.service.free;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.PageInfo;
import com.footsalhaja.mapper.free.FreeMapper;
import com.footsalhaja.mapper.free.FreeReplyMapper;

@Service
@Transactional
public class FreeServiceImpl implements FreeService{
	 
	@Autowired
	private FreeMapper freeMapper;
	
	@Autowired
	private FreeReplyMapper replyMapper;
	
	
	@Override
	public int insert(BoardDto board) {
		return freeMapper.insert(board);
	}


	@Override
	public List<BoardDto> listBoard(int page, String type, String keyword, PageInfo pageInfo, String category) {
		
		int records = 10; // 게시글 갯수
		int offset = (page - 1) * records; // 어디서부터
		
		int countAll = freeMapper.countAll(type, "%" + keyword + "%"); // 총 게시물 갯수
		int lastPage = (countAll - 1) / records + 1; // 마지막 페이지
		
		// 5페이지씩 보이게
		int leftPageNumber = (page - 1) / 5 * 5 + 1;
		int rightPageNumber = leftPageNumber + 4;
		rightPageNumber = Math.min(rightPageNumber, lastPage);
		
		// 이전 버튼 유무
		boolean hasPrevButton = page > 5;
		// 다음 버튼 유무
		boolean hasNextButton = page <= ((lastPage - 1) / 5 * 5);
		
		// 이전버튼 눌렀을 때 가는 페이지 번호
		int jumpPrevPageNumber = (page - 1) / 5 * 5 - 4;
		// 다음버튼 눌렀을 때 가는 페이지 번호
		int jumpNextPageNumber = (page - 1) / 5 * 5 + 6; 
		
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);
		pageInfo.setJumpPrevPageNumber(jumpPrevPageNumber);
		pageInfo.setJumpNextPageNumber(jumpNextPageNumber);
		pageInfo.setCurrentPageNumber(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setLastPageNumber(lastPage);
		
	
		return freeMapper.list(offset, records, type,  "%" + keyword + "%", category);
	}
	 
	// 게시물 보기
	@Override
	public BoardDto get(int fb_number, String member_userId) {
		return freeMapper.select(fb_number, member_userId);
	} 
	
	@Override
	public BoardDto get(int fb_number) {
		return get(fb_number, null);
	}
	 
	@Override
	public int update(BoardDto board, MultipartFile[] addFiles, List<String> removeFiles) {
		
		// removeFiles 에 있는 파일명으로 
		if (removeFiles != null) {
			
		for (String fileName : removeFiles) {
			// 1. File 테이블에서 record 지우기
			System.out.println(fileName);
			
			freeMapper.deleteByBoardIdAndFileName(board.getFb_number(), fileName);
			
			// 2. 저장소에 실제 파일 지우기
			String path = "D:\\study\\project\\project"+ board.getFb_number() + "\\" + fileName;
			File file = new File(path);
			
			file.delete();
			}
		}
		
		
		for (MultipartFile file : addFiles) {
			//같은 이름의 파일을 추가 시 덮어씌우기 위해 File table에 해당 파일명 지우는 작업
			freeMapper.deleteByBoardIdAndFileName(board.getFb_number(),file.getOriginalFilename());
		}
		
		for (MultipartFile file : addFiles) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				String originalFileName = file.getOriginalFilename(); //오리지날 파일명 String
				  
				String fb_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
				
				String extension  = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자(파일 타입)
				
				int fb_fileType;
				
				//파일 확장자가 jpg 여부 체크하기 위해 (나중에 다른걸로 바꾸는거도 좋와용)
				if (extension  == "jpg") {
					fb_fileType = 1;
				}else {
					fb_fileType = 0;
				}
				
				// 파일 저장
				// ab_number 이름의 새 폴더 만들기 (파일 첨부된 게시물 ab_number번호의 새폴더가 생성됨)
				File folder = new File("D:\\study\\project\\project"+ board.getFb_number());
				folder.mkdirs();
				
				File dest = new File(folder, fb_fileName);
				//첨부된 파일을 새 폴더에 전송
				try {
					file.transferTo(dest);
				} catch (Exception e) {
					//@@Transactional은 RuntimeExceptional에서만 rollback됨
					e.printStackTrace();
					throw new RuntimeException(e);
				}
				
				//파일 경로
				String fb_filePath = folder.getAbsolutePath();
				
				freeMapper.insertFile(board.getFb_number(), fb_fileName, fb_filePath, fb_fileType);
			}
		}
		
		return freeMapper.update(board);
	}
	
	
	// 게시물 지우기
	@Override
	public int remove(int fb_number) {
		//DB파일폴더 지우기
		String path = "D:\\study\\project\\project" +fb_number;
		File folder = new File(path);
		
		File[] listFiles = folder.listFiles();

		if (listFiles != null) {
				for (File file : listFiles) {
					file.delete();
				}
			}
		
		for (File file: listFiles) {
			file.delete();
		}
		folder.delete();
		
		//파일 지우기
		freeMapper.deleteFileByBoardId(fb_number);
		// 댓글 지우기
		replyMapper.deleteByBoardId(fb_number);
		// 좋아요 지우기
		freeMapper.deleteLikeByBoardId(fb_number);
		 
		// 게시물 지우기
		return freeMapper.delete(fb_number);
	}
	
	// 좋아요
	@Override
	public Map<String, Object> updateLike(String fb_number, String member_userId) {
		// System.out.println(fb_number);
		
		Map<String, Object> map = new HashMap<>();
		
		// freeBoard_fb_number랑 member_userId으로 좋아요 테이블에서 검색
		int cnt = freeMapper.getLikeByBoardNumberAndUserId(fb_number, member_userId);
		// System.out.println(cnt);
		if (cnt == 1) {
			// 있으면 취소
			freeMapper.deleteLike(fb_number, member_userId);
			map.put("current", "not liked");			
		} else { 
			// 없으면 추가
			int a = freeMapper.insertLike(fb_number, member_userId);
			// System.out.println(a);
			map.put("current", "liked");			
		}
		
		// 현재 몇개인지
		int countAll = freeMapper.countLikeByBoardNumber(fb_number);
		map.put("count", countAll);
		
		return map;
	}
	
	// 조회수
	@Override
	public int updateViewCount(int fb_number) {
		return freeMapper.updateViewCount(fb_number);
	}
	
	// 좋아요 순위
	@Override
	public List<BoardDto> likeRank(BoardDto board) {
		return freeMapper.likeRank(board);
	}
	
	//파일 등록
	@Override
	public int insertFile(BoardDto board, MultipartFile[] files) {
		// DB에 게시물 정보 저장
		int cnt = freeMapper.insert(board);
		
		for (MultipartFile file : files) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				String originalFileName = file.getOriginalFilename(); //오리지날 파일명 String
				  
				String fb_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
				
				String extension  = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자(파일 타입)
				
				int fb_fileType;
				
				//파일 확장자가 jpg 여부 체크하기 위해 (나중에 다른걸로 바꾸는거도 좋와용)
				if (extension  == "jpg") {
					fb_fileType = 1;
				}else {
					fb_fileType = 0;
				}
				
				// 파일 저장
				// ab_number 이름의 새 폴더 만들기 (파일 첨부된 게시물 ab_number번호의 새폴더가 생성됨)
				File folder = new File("D:\\study\\project\\project"+ board.getFb_number());
				folder.mkdirs();
				
				File dest = new File(folder, fb_fileName);
				//첨부된 파일을 새 폴더에 전송
				try {
					file.transferTo(dest);
				} catch (Exception e) {
					//@@Transactional은 RuntimeExceptional에서만 rollback됨
					e.printStackTrace();
					throw new RuntimeException(e);
				}
				
				//파일 경로
				String fb_filePath = folder.getAbsolutePath();
				
				freeMapper.insertFile(board.getFb_number(), fb_fileName, fb_filePath, fb_fileType);
			}
		}
		return cnt;
	}
}
