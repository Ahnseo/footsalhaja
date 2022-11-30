package com.footsalhaja.domain.academy;

import lombok.Data;

@Data
public class Criteria {
	
	private int pageNum;
	private int amount;
	
	//생성자 통해서 기본값을 1페이지, 10개로 지정해서 처리
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
