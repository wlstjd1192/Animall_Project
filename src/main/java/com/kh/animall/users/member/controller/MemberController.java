package com.kh.animall.users.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.animall.users.member.model.service.MemberService;
import com.kh.animall.users.member.model.vo.Member;

@SessionAttributes(value= { "member" })
@Controller
public class MemberController {
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private MemberService memberService;
	
	/*회원가입(enroll) 페이지로 이동 - 인덱스, 헤더, 풋터 연결 후 재확인 필요*/
	
	@RequestMapping("users/member/memberEnroll.do")	
	public String memberEnroll() {
		
		System.out.println("member/memberEnroll.do 접근 확인");
		
		return "users/member/memberEnroll";
				
	}
	
	@RequestMapping("users/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model model) {
		
		
		
		member.setEmail(member.getEmail()+member.getDomain()); //email합치기
		member.setAddress(member.getAddr1()+member.getAddr2()+" "+member.getZip()); //주소 합치기
		String plainPassword = member.getPwd();
		System.out.println("memberEnroll : " + member);
		
		String encryptPassword = bcryptPasswordEncoder.encode(plainPassword);
		
		System.out.println("원문 : " + plainPassword);
		System.out.println("암호문 : " + encryptPassword);
		member.setPwd(encryptPassword);
		

		try {
		// 1. 서비스를 통한 비즈니스 로직 수행
		int result = memberService.insertMember(member);
		
		// 2. 반환 화면 처리
		String loc="/";
		String msg = "";
		
		if(result > 0) msg = "회원가입 성공!";
		else msg = "회원가입 실패!";
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		} catch (Exception e) {
			System.out.println("회원가입 에러 발생");
			e.printStackTrace();
			// 기존의 예외를 우리가 지정한 예외 형식으로 
			// 바꾸어 보내기 위해 MemberException을 호출한다.
			// throw new MemberException(e.getMessage());
		}
		
		return "common/msg";
		
	}
	
	// 2번 방법 (어노테이션 선언 방식)
	@RequestMapping("users/member/memberLogin.do")
	public String memberLogin(
				@RequestParam String id,
				@RequestParam String pwd,
				Model model
			) {
		
		// 반환 화면 처리
		
		String loc = "/";
		String msg = "";
		
		
		Member m = memberService.selectOneMember(id);
		
		System.out.println(m);
		
		if ( m == null ) {
			msg = "존재하지 않는 아이디입니다.";
		} else {
			
			if( bcryptPasswordEncoder.matches(pwd, m.getPwd()) ) {
				msg = "로그인에 성공하였습니다!";
				model.addAttribute("member", m);
				// @SessionAttributes 에 등록된 'member'로 인식하면서
				// 자동으로 세션 영역에 해당 객체를 저장한다.
			} else {
				msg = "비밀번호가 일치하지 않습니다.";
			}
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		
		return "common/msg";
		
	}
	
	@RequestMapping("users/member/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		
	if(!sessionStatus.isComplete()) {
		sessionStatus.setComplete();
		}
	
	return "redirect:/";
	
}
	
	
	
	
	
	
	
	
	
	
}