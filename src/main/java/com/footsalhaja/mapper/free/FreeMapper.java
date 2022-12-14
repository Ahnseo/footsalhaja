package com.footsalhaja.mapper.free;

import java.util.List;

import com.footsalhaja.domain.free.BoardDto;
import com.footsalhaja.domain.free.FreeReplyDto;

public interface FreeMapper {

	int insert(BoardDto board);

	public BoardDto select(int fb_number, String member_userId);
	
	default BoardDto select(int fb_number) {
		return select(fb_number, null);
	}
	
	int update(BoardDto board);

	int delete(int fb_number);
	
	List<BoardDto> list(int offset, int records, String type, String keyword, String category);

	int countAll(String type, String keyword);

	int getLikeByBoardNumberAndUserId(String fb_number, String member_userId);

	int countLikeByBoardNumber(String fb_number);

	int deleteLike(String fb_number, String member_userId);

	int insertLike(String fb_number, String member_userId);

	int deleteLikeByBoardId(int fb_number);

	int updateViewCount(int fb_number);

	List<BoardDto> likeRank(BoardDto board);
	
	public void insertFile(int fb_number, String fb_fileName, String fb_filePath, int fb_fileType);

	public void deleteFileByBoardId(int fb_number);

	public void deleteByBoardIdAndFileName(int fb_number, String originalFilename);

}
