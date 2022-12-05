package com.footsalhaja.domain.free;

import lombok.Data;

@Data
public class PageInfo {
	private int lastPageNumber;
	private int leftPageNumber;
	private int rightPageNumber;
	private int currentPageNumber;
	private int jumpPrevPageNumber;
	private int jumpNextPageNumber;
	private boolean hasPrevButton;
	private boolean hasNextButton;
	
	
}
