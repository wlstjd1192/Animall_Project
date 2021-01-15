package com.kh.animall.users.member.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.animall.users.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		
		return sqlSession.insert("memberMapper.insertMember", member);
	}

	@Override
	public Member selectOneMember(String id) {
		
		return sqlSession.selectOne("memberMapper.loginMember", id);
	}

	@Override
	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMember(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int checkIdDuplicate(HashMap<String, Object> hmap) {
		// TODO Auto-generated method stub
		return 0;
	}

}
