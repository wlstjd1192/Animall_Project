<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="kr">
<head>
	<meta charset="UTF-8" />
	<title>ANIMALL</title>
	
	<!-- mobile responsive meta -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  
  <!-- Bootstrap -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/bootstrap/bootstrap.min.css">
  <!-- magnific popup -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/magnific-popup/magnific-popup.css">
  <!-- Slick Carousel -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/slick/slick.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/slick/slick-theme.css">
  <!-- themify icon -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/themify-icons/themify-icons.css">
  <!-- animate -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/animate/animate.css">
  <!-- Aos -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/aos/aos.css">
  <!-- swiper -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/swiper/swiper.min.css">
  <!-- Stylesheets -->
  <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">


  
  <!--Favicon-->
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.png" type="image/x-icon">
  
  <!-- 헤더  -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  
  <!-- fontawesome 사용 -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css">
	
</head>



<body>
<!-- 로딩 중 표시 -->
<div class="preloader">
   <img  src="${pageContext.request.contextPath }/resources/images/loading_dog2.gif" alt="preloader">
</div>


    
    <!-- 글꼴 적용 -->
<div style="font-family: Nanum Gothic">


<!-- nav bar -->

<div class="primeContainer">
	<div class="bigContainer">
   		<div class="logoContainer">
	       <a href="${pageContext.request.contextPath}/index/Load.do">
	          <img src="${pageContext.request.contextPath}/resources/images/cat_dog_logo.png" alt="logo">
	       </a>
	       <div class="logoMargin">
	       </div>
   		</div>
   		<div class="logoBlank">
   		</div>
   		<div class="rightMenuContainer">
   		
   		
   			  <!-- 로그인 처리 -->
            <c:if test="${empty member}">
            <div>
             <div class="rightMenu">
                  <a data-toggle="modal" href="#loginModal">Login</a>                  
             </div>
             </div>
             
             <div>
             <div class="rightMenu">
                  <a href='${pageContext.request.contextPath}/users/member/memberEnroll.do'>Join</a>
                  
             </div>
             </div>
            </c:if>
            
            
                
                <c:if test="${!empty member}"> <!-- 로그인 시(m이 비어있지 않다면) -->
               <div class="rightMenu">
                  <span>${member.nname} 님</span>
               </div>
               <div class="rightMenu">
                    <a href='${pageContext.request.contextPath}/users/member/memberLogout.do'>Logout</a>
               <!-- <button class="btn btn-outline-success my-2 my-sm-0"
                           type="button"
                           onclick="location.href='${pageContext.request.contextPath}/users/member/memberLogout.do'">로그아웃</button> -->
               </div>      
               </c:if>
               
               
		    <div>
			    <div class="rightMenu">
			    <c:choose>
					    <c:when test="${member.mtype eq 'ADMIN'}">
					       <a href='${pageContext.request.contextPath}/admin/adminPage.do'>AdminPage</a>
					    </c:when>
					    <c:when test="${member.mtype eq 'USER'}">
					       <a href='#'>Mypage</a>
					    </c:when>
					    <c:otherwise>
					        <a href='javascript:void(0);' onclick=" alert('로그인이 필요합니다')">MyPage</a>
					    </c:otherwise>
				</c:choose>
			    </div>
		    </div>
		    <div>
			    <div class="rightMenu" style="border : none;">
			      	<a href='${pageContext.request.contextPath}/cart/cartList.do?mno=${member.mno}'>Cart</a>
			    </div>
		    </div>
   		</div>
   	</div>      
   	
   	
   	
   	
   	<!-- Modal시작 -->
				<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
				<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
					aria-labelledby="loginModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="loginModalLabel">로그인</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<!--로그인폼 -->
							<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
							<form action="${pageContext.request.contextPath}/users/member/memberLogin.do" method="post">
								<div class="modal-body">
									<input type="text" class="form-control" name="id"
										placeholder="아이디" required> <br /> 
										<input
										type="password" class="form-control" name="pwd"
										placeholder="비밀번호" required>
								</div>
								<div class="modal-footer">
									<button type="submit" class="btn btn-outline-success">로그인</button>
									<button type="button" class="btn btn-outline-success"
										data-dismiss="modal">취소</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- Modal 로그인폼 끝-->
   	
   	
   	
    
    <div class="bigContainer">  
    	<div class="leftMenuContainer">
		    <div class="totalCategory">
		    
		      <button class="dropbtn"><i class="fas fa-bars"></i> Menu</button>
			      <div class="dropdown-content">
			      		<a href="#">Beauty</a>
				        <a href="#">Living</a>
				        <a href="#">Food</a>
				        <a href="${pageContext.request.contextPath }/board/list">AniPic</a>
                        <a href="${pageContext.request.contextPath }/styBoard/list">AniSalon</a> 
				        <a href="#">공지사항</a>
				        <a href="#">마이페이지</a>
				        <a href="#">장바구니</a>
				        <a href="#">FAQ</a>
				        
			      </div>
		    </div>
		    <div>
			    <div class="leftMenu">
			      	<a href='#'>Beauty</a>
			    </div>
		    </div>
		    <div>
			    <div class="leftMenu">
			      	<a href='#'>Living</a>
			    </div>
		    </div>
		    <div>
			    <div class="leftMenu">
			      	<a href='#'>Food</a>
			    </div>
		    </div>
		    <div>
                  <div class="leftMenu">
                     <a href="${pageContext.request.contextPath }/board/list">AniPic</a>
                  </div>
            </div>
             <div>
                  <div class="leftMenu">
                     <a href="${pageContext.request.contextPath }/styBoard/list">AniSalon</a>
                  </div>
            </div>
    		<div class="leftMenuBlank">
    		</div>
   		</div>
   		<div class="searchContainer">
	   		<div class="searchMargin">
	   		</div>
	   		<input id="search" name="search">
	 	  	</input>
	 	  	<div class="searchIcon">
	 	  	<i class="fas fa-search"></i>
	   		</div>
   		</div>
   </div> 
</div> 

<!-- /navigation 여기까지 fixed 적용 -->
<!-- 글꼴 적용 -->
</div> 

<!-- position:fixed로 인한 화면 겹침 현상 방지를 위해 -->
<div class="topMargin" style="height : 175px">
</div>
	


<div class="back-to-top" >
<i class="fas fa-arrow-circle-up" id="topButton"></i>       
</div>
	
	
	
</body>
</html>