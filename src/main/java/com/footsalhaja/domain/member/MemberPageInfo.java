package com.footsalhaja.domain.member;

import lombok.Data;

@Data
public class MemberPageInfo {

	private boolean hasPrevButton;
	private boolean hasNextButton;
	
	private int jumpPrevPageNumber;
	private int jumpNextPageNumber;
	
	private int currentPageNumber;
	private int lastPageNumber;
	private int leftPageNumber;
	private int rightPageNumber;
}
