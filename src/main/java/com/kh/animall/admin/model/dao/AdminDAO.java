package com.kh.animall.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.animall.admin.model.vo.Member;
import com.kh.animall.admin.model.vo.MemberBoard;
import com.kh.animall.index.model.vo.IndexProduct;

public interface AdminDAO {

	List<Map<String, String>> selectMemberList(int cPage, int numPerPage);

	int selectMemberTotalContents();

	void memberDelete(int num);

	void memberWarnY(int mno);

	void memberWarnN(int mno);

	List<Map<String, String>> selectStylistList(int cPage, int numPerPage);

	int selectStylistTotalContents();

	void stylistDelete(int num);

	List<MemberBoard> memberSearch(String searchOption, String keyword);

	int searchMemberTotalContents(String searchOption, String keyword);

	List<Map<String, String>> adminMemberList(int cPage, int numPerPage);

}
