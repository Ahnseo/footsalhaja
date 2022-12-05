package com.footsalhaja.domain.academy;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	
	//생성자 통해서 기본값을 1페이지, 10개로 지정해서 처리
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//검색 조건이 각 글자(T,W,C)로 구성되어 있으므로 
	//검색 조건을 배열로 만들어 한번에 처리 (MyBatis의 동적 태그를 활용)
		public String[] getTypeArr() {
			
			return type == null? new String[] {} : type.split("");
		}
}
