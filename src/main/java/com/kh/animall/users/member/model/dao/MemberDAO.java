package com.kh.animall.users.member.model.dao;

import java.util.HashMap;

import com.kh.animall.users.member.model.vo.Member;

public interface MemberDAO {
	
	int insertMember(Member member);

	Member selectOneMember(String id);

	int updateMember(Member member);

	int deleteMember(String id);
	
	int checkIdDuplicate(HashMap<String, Object> hmap);

}
