<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 가입 창</title>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<style>
		div#enroll-container{width:400px; margin:0 auto; text-align:center;}
		div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
		div#enroll-container table th{text-align: right; padding-right:10px;}
		div#enroll-container table td{text-align: left;}
		/*중복아이디체크관련*/
		div#userId-container{position:relative; padding:0px;}
		div#userId-container span.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
		div#userId-container span.ok{color:green;}
		div#userId-container span.error, span.invalid{color:red;}
		
		/*중복아이디체크관련*/
		tr>td>h5 {
		color : red;
		}
		
		.validate {
			border : 1px solid red;
		}
	</style>
</head>
<body>
	<h1 align="center">회원가입</h1>
	<hr />
	<div id="container">
		
		<section id="content">
			<div id="enroll-container">
				<form name="memberEnrollFrm" action="memberEnrollEnd.do" method="post" onsubmit="return fn_enroll_validate();" >
					<table align="center">
			<tr>
				<td style="width : 150px;">
					<h4>아이디</h4>
				</td>
				<td style="width : 150px;">
					<input type="text" size="20" name="id" id="id" class="form-control" placeholder="아이디" required="required" onkeyup="dupCheck(this)">
				</td>
				<td style="width : 90px;">
					&nbsp;<button type="button" class="btn btn-default" id="idCheck">중복확인</button>
				</td>
				<td style="width : 110px;">
					<h5 style=""></h5>
				</td>
			</tr>
			<tr>
				<td>
					<h4>비밀번호</h4>
				</td>
				<td>
					<input type="password" size="20" name="pwd" id="pwd" class="form-control" placeholder="비밀번호" required="required" onkeyup="validate(this)">
				</td>
				<td colspan="2">
					<h5></h5>
				</td>
			</tr>
			<tr>
				<td>
					<h4>비밀번호 확인</h4>
				</td>
				<td>
					<input type="password" size="20" name="pwd2" id="pwd2" class="form-control" placeholder="비밀번호 확인" onkeyup="chkPwd()" required="required">
				</td>
				<td colspan="2">
					<h5></h5>
				</td>
			</tr>
			<tr>
				<td>
					<h4>닉네임</h4>
				</td>
				<td>
					<input type="text" size="20" name="nname" id="nname" class="form-control" placeholder="닉네임" required="required" onkeyup="dupCheck(this)">
				</td>
				<td>
					&nbsp;<button type="button" class="btn btn-default" id="nickCheck">중복확인</button>
				</td>
				<td>
					<h5 style=""></h5>
				</td>
			</tr>
			
			<tr>
				<td rowspan="3">
					<h4>주소</h4>
				</td>
				<td>
					<input type="text" size="20" name="zip" id="zip" class="form-control" placeholder="우편번호">
				</td>
				 				
				<td>
					&nbsp;<button type="button" class="btn btn-default" onclick="execDaumPostcode();">주소검색</button>
				</td>
				
			</tr>
			<tr>
				
				<td colspan="2">
					<input type="text" size="20" name="addr1" id="addr1" class="form-control" placeholder="주소">
				</td>
			</tr>
			<tr>
				
				<td colspan="2">
					<input type="text" size="20" name="addr2" id="addr2" class="form-control" placeholder="상세주소">
				</td>
			</tr>
				<tr>
				<td>
					<h4>이메일</h4>
				</td>
				<td>
					<input type="text" size="20" name="email" id="email" class="form-control" placeholder="이메일" required="required" onkeyup="dupCheck(this)">
				</td>
				<td>
					<select name="domain" id="domain" class="btn btn-default form-control" style="width : 130px; background : none;" onchange="validate($('#email'))">
						<option value="none" >- 선택 -</option>
						<option value="self" >- 직접입력 -</option>
						<option value="@naver.com" >@naver.com</option>
						<option value="@gmail.com" >@gmail.com</option>
						<option value="@hanmail.net" >@hanmail.net</option>
						<option value="@nate.com" >@nate.com</option>
					</select>
				</td>
				<td>
					<h5></h5>
				</td>
			</tr>
			
		</table>
		<br />
		<div style="text-align: center;">
		<input type="submit" class="btn btn-outline-success" value="가입" >
		<input type="reset"  class="btn btn-outline-danger" value="취소">
		</div>
		
		</form>			
			<script>
			
			$(function(){
				
				$("#password2").blur(function(){
					var p1=$("#password_").val(), p2=$("#password2").val();
					if(p1!=p2){
						alert("패스워드가 일치하지 않습니다.");
						$("#password_").focus();
					}
				});
				
				/* 아이디 중복검사 이벤트 추가 */
				$("#userId_").on("keyup", function(){
			        var userId = $(this).val().trim();
			        
			        if(userId.length<4) {
			        	$(".guide.error").hide();
			        	$(".guide.ok").hide();
			        	$(".guide.invalid").show();
			        	return;
			        	
			        } else {
			        	
				        $.ajax({
				            url  : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
				            data : {userId:userId},
				            dataType: "json",
				            success : function(data){
				                console.log(data);
				                // if(data=="true") //stream 방식
				                if(data.isUsable==true){ //viewName 방식
				                    $(".guide.error").hide();
				                    $(".guide.invalid").hide();
				                    $(".guide.ok").show();
				                    $("#idDuplicateCheck").val(1);
				                } else {
				                    $(".guide.error").show();
				                    $(".guide.invalid").hide();
				                    $(".guide.ok").hide();
				                    $("#idDuplicateCheck").val(0);
				                }
				            }, error : function(jqxhr, textStatus, errorThrown){
				                console.log("ajax 처리 실패");
				                //에러로그
				                console.log(jqxhr);
				                console.log(textStatus);
				                console.log(errorThrown);
				            }
			        	});
			     	}
			     //console.log(userId);
				});
			});
			
			function validate(){
				var userId = $("#userId_");
				if(userId.val().trim().length<4){
					alert("아이디는 최소 4자리이상이어야 합니다.");
					userId.focus();
					return false;
				}
				
				//아이디중복체크여부
			    if($("#idDuplicateCheck").val()==0){
			        alert("사용가능한 아이디를 입력해주세요.");
			        return false();
			    }
				
				return true;
			}
			</script>
			
			<!-- 주소 검색 api -->
			<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			
			<script>
			function execDaumPostcode() {
			    new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
			            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                extraRoadAddr += data.bname;
			            }
			            // 건물명이 있고, 공동주택일 경우 추가한다.
			            if(data.buildingName !== '' && data.apartment === 'Y'){
			                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			            }
			            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			            if(extraRoadAddr !== ''){
			                extraRoadAddr = ' (' + extraRoadAddr + ')';
			            }
			            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			            if(fullRoadAddr !== ''){
			                fullRoadAddr += extraRoadAddr;
			            }

			            // 우편번호와 주소 정보를 해당 필드에 넣는다.
			            document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
			            document.getElementById('addr1').value = fullRoadAddr;
			            document.getElementById('addr2').focus();
			        }
			    }).open();
			}
			
    		</script>		
	</section>			
	</div>
	
</body>
</html>