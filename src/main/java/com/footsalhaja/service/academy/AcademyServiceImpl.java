package com.footsalhaja.service.academy;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.footsalhaja.domain.academy.BoardDto;
import com.footsalhaja.domain.academy.Criteria;
import com.footsalhaja.mapper.academy.AcademyMapper;
import com.footsalhaja.mapper.academy.AcademyReplyMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class AcademyServiceImpl implements AcademyService{
	
	@Autowired
	private AcademyMapper mapper;
	
	@Autowired
	private AcademyReplyMapper replyMapper;
	
	@Autowired
	private S3Client s3Client;
	
	@Value("${aws.s3.bucket}")
	private String bucketName;
	
	
	@Override
	public void insert(BoardDto board) {

		mapper.insert(board);
	}
	
	@Override
	public List<BoardDto> listBord(Criteria cri, String category) {
		System.out.println("get List with Criteria: " +cri);
		
		int offset = (cri.getPageNum() -1) * cri.getAmount();
		int records = cri.getAmount();
		System.out.println(cri.getType());
		
		/* cri.setKeyword("%"+cri.getKeyword()+"%"); */
		
		return mapper.getListWithPaging(cri, offset,records, category);
	}
	
	@Override
	public BoardDto get(int ab_number, String member_userId) {
	
		return mapper.select(ab_number, member_userId);
	}
	
	@Override
	public int modify(BoardDto board, MultipartFile[] addFiles, List<String> removeFiles) {
		
		// removeFiles 에 있는 파일명으로 
		if (removeFiles != null) {
			
		for (String fileName : removeFiles) {
			// 1. File 테이블에서 record 지우기
			System.out.println(fileName);
			
			mapper.deleteByBoardIdAndFileName(board.getAb_number(), fileName);
			
			// 2. 저장소에 실제 파일 지우기
			String originalfileName = fileName.substring(36);
			System.out.println(originalfileName);
			deleteFile(board.getAb_number(), originalfileName);
			}
		}
		
		//UUID+파일이름 으로 중복된 이름이어도 저장 가능해짐
		/*
		 * for (MultipartFile file : addFiles) { //같은 이름의 파일을 추가 시 덮어씌우기 위해 File table에
		 * 해당 파일명 지우는 작업 mapper.deleteByBoardIdAndFileName(board.getAb_number(),file.
		 * getOriginalFilename()); }
		 */
		
		for (MultipartFile file : addFiles) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				String originalFileName = file.getOriginalFilename(); //오리지날 파일명 String
				  
				String ab_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
				
				String extension  = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자(파일 타입)
				
				int ab_fileType;
				
				//파일 확장자가 jpg 여부 체크하기 위해 (나중에 다른걸로 바꾸는거도 좋와용)
				if (extension  == "jpg") {
					ab_fileType = 1;
				}else {
					ab_fileType = 0;
				}
				try {
					// S3에 파일 저장
					// 키 생성
					String key = "academy/" + board.getAb_number() + "/" + file.getOriginalFilename();

				// 파일 저장
				// ab_number 이름의 새 폴더 만들기 (파일 첨부된 게시물 ab_number번호의 새폴더가 생성되면서 파일 저장)
					PutObjectRequest putObjectRequest = PutObjectRequest.builder()
							.bucket(bucketName)
							.key(key)
							.acl(ObjectCannedACL.PUBLIC_READ)
							.build();
					
					// requestBody
					RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
					
					// object(파일) 올리기
					s3Client.putObject(putObjectRequest, requestBody);
					
					//파일 경로
					String ab_filePath = key;
					mapper.insertFile(board.getAb_number(), ab_fileName, ab_filePath, ab_fileType);

				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException(e);
				}
				
			}
		
		}
		return mapper.modify(board);
	}
	
	@Transactional
	@Override
	public int remove(int ab_number) {
		//DB파일폴더 지우기
		BoardDto board = mapper.select(ab_number);
		
		List<String> fileNames = board.getAb_fileName();
		
		if (fileNames != null) {
			for (String fileName : fileNames) {
				String originalfileName = fileName.substring(36);
				// s3 저장소의 파일 지우기
				deleteFile(ab_number, originalfileName);
			}
		}
		
		//파일 지우기
		mapper.deleteFileByBoardId(ab_number);
		//댓글 지우기
		replyMapper.deleteByBoardId(ab_number);
		//좋아요 지우기
		mapper.deleteLikeByBoardId(ab_number);
		//게시물 지우기
		return mapper.remove(ab_number);
	}
	
	private void deleteFile(int ab_number, String fileName) {
		String key = "academy/" + ab_number + "/" + fileName;
		
		System.out.println("deleteFile key: "+key);
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3Client.deleteObject(deleteObjectRequest);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri, 123);
	}
	
	@Override
	public Map<String, Object> updateLike(String ab_number, String member_userId) {
		Map<String, Object> map = new HashMap<>();
		
		int cnt = mapper.getLike(ab_number, member_userId);
		if (cnt == 1) {
			// ab_number와 member_userId으로 좋아요 테이블 검색해서 있으면?
			// 삭제
			mapper.deleteLike(ab_number, member_userId);
			map.put("current", "not liked");
			
		} else {
			// 없으면?
			// insert
			mapper.insertLike(ab_number, member_userId);
			map.put("current", "liked");
		}

		int countAll = mapper.countLikeByab_number(ab_number);
		// 현재 몇개인지
		map.put("count", countAll);
		
		return map;
	}
	
	@Override
	public BoardDto get(int ab_number) {
		return get(ab_number, null);
	}
	
	@Override
	public int updateViewCount(int ab_number) {
		return mapper.updateViewCount(ab_number);
	}
	
	@Override
	@Transactional
	public int insertFile(BoardDto board, MultipartFile[] files) {
		// DB에 게시물 정보 저장
		int cnt = mapper.insert(board);
		
		for (MultipartFile file : files) {
			if (file != null && file.getSize() > 0) {
				// db에 파일 정보 저장
				String originalFileName = file.getOriginalFilename(); //오리지날 파일명 String
				  
				String ab_fileName = UUID.randomUUID() + originalFileName; //랜덤 UUID+파일이름으로 저장될 파일 새 이름
				
				String extension  = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자(파일 타입)
				
				int ab_fileType;
				
				//파일 확장자가 jpg 여부 체크하기 위해 (나중에 다른걸로 바꾸는거도 좋와용)
				if (extension  == "jpg") {
					ab_fileType = 1;
				}else {
					ab_fileType = 0;
				}
				try {
					// S3에 파일 저장
					// 키 생성
					String key = "academy/" + board.getAb_number() + "/" + file.getOriginalFilename();
				// 파일 저장
				// ab_number 이름의 새 폴더 만들기 (파일 첨부된 게시물 ab_number번호의 새폴더가 생성됨)
					PutObjectRequest putObjectRequest = PutObjectRequest.builder()
							.bucket(bucketName)
							.key(key)
							.acl(ObjectCannedACL.PUBLIC_READ)
							.build();
					
					// requestBody
					RequestBody requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
					
					// object(파일) 올리기
					s3Client.putObject(putObjectRequest, requestBody);
					
					//파일 경로
					String ab_filePath = key;
							
							mapper.insertFile(board.getAb_number(), ab_fileName, ab_filePath, ab_fileType);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException(e);
				}
				
			}
		}
		return cnt;
	}

	//좋아요 순위
	@Override
	public List<BoardDto> likeRank(BoardDto board) {
		return mapper.likeRank(board);
	}
	
}
