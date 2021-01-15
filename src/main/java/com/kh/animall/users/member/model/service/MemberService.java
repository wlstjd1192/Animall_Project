package com.kh.animall.users.member.model.service;

import com.kh.animall.users.member.model.vo.Member;

public interface MemberService {
	
	int insertMember(Member member);
	
	Member selectOneMember(String id);
	
	int updateMember(Member member);
	
	int checkIdDuplicate(String id);
	
	int deleteMember(String id);
	

}
