package com.footsalhaja.domain.member;

import java.util.List;

import com.footsalhaja.domain.academy.AcademyReplyDto;
import com.footsalhaja.domain.free.FreeReplyDto;

import lombok.Data;

@Data
public class UserReplyDto {

	private List<MemberDto> userReplyList;
}
