<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.kh.semi.member.product.model.vo.*,com.kh.semi.member.product.model.vo.ReviewAvg, java.util.*"%>

<%
   // 제품 정보
   Product p = (Product) request.getAttribute("product");
   // 제품 리스트 
   ArrayList<Product> list = (ArrayList<Product>) request.getAttribute("list");
   // 리뷰정보 
   ArrayList<Review> rlist = (ArrayList<Review>) request.getAttribute("rlist");
   // 카테고리 1번
   FirstCategory ca1 = (FirstCategory) request.getAttribute("ca1");
   // 카테고리 1번 리스트
   ArrayList<FirstCategory> clist1 = (ArrayList<FirstCategory>) request.getAttribute("clist1");
   // 카테고리 2번 리스트
   ArrayList<SecondCategory> clist2 = (ArrayList<SecondCategory>) request.getAttribute("clist2");
   // 리뷰 별점 통계
   ReviewAvg reStar = (ReviewAvg)request.getAttribute("reStar");
   // 리뷰 별점 개수
   ArrayList<ReviewStarCount> reStarCount = (ArrayList<ReviewStarCount>)request.getAttribute("reStarCount");
   ReviewStarCount rsc = (ReviewStarCount)request.getAttribute("rsc");
   
   // 제품 상세보기 브랜드 이름 가져오기
   Brand br = (Brand)request.getAttribute("br");

   /* ArrayList<String> = new ArrayList<String>();
   
   if(p.getP_img1_changename() !=null){
      pImg.add(p.getP_img1_changename());
   }
   if(p.getP_img2_changename() !=null){
      pImg.add(p.getP_img2_changename());
   }
   if(p.getP_img3_changename() !=null){
      pImg.add(p.getP_img3_changename());
   } */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>제품 구매하기</title>

<link rel="stylesheet" type="text/css" href="/cosme/resources/api/fancySelect/css/styles.css">

<style>
.product_count>input {
   background: #fff;
   transition: width 2s;
}
.product_count>input:active {
   background: #9cd6e5;
   color : #fff;
   
}

/* ====================제품 상세정보   */
.infoList {
   width: 80%;
   margin : 0 auto;
   display: block;
   
   
}

.infoList h5 {
   width: 100%;
   
   
}

.owl-nav {
   display: none;
}

#home>h5, #home>img {
   width: 100%;
   
   height: auto;
   text-align: center;
   margin: 5% auto;
   display: block;
}

#home>img {
   
}

.s_product_text {
   text-align: center;
}

#myTabContent {
   
}
/* ===============스크롤 css */
.ScrollButton {
        position: fixed;   /* 버튼의 위치 고정 */
        right: 2%;       /* x 위치 입력 */
        cursor: pointer;   /* 호버링 했을 때 커서 모양 변경 */
        z-index: 10;       /* 다른 태그에 가려지지 않게 우선순위 변경 */
        display: none;     /* 스크롤 위치에 상관없이 보이게 하려면 생략 */
      }
      /* 두 태그에 각각 y 위치 입력 */
      #TopButton {
        bottom: 15%;        
      }
      #BottomButton {
        bottom: 10%;
      }

.list li {
   display : block !important;
}
</style>

</head>
<body>
   <%@ include file="/views/users/common/header.jsp"%>

   <!--================Single Product Area =================-->

   <div class="product_image_area" style="border-top: 1px solid #e2e2e2;">
   
   
                      
      <div class="container">
      
         <div class="row s_product_inner">
         
            <div class="col-lg-6">
            
               <div class="s_product_img">
                  <div id="carouselExampleIndicators" class="carousel slide"
                     data-ride="carousel">
                     <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0"
                           class="active"><img
                           src="/cosme/resources/productPhotoFiles/<%=p.getP_img1_changename()%>"
                           alt="" style="width: 100%;"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1">
                           <img
                           src="/cosme/resources/productPhotoFiles/<%=p.getP_img2_changename()%>"
                           alt="" style="width: 100%;">
                        </li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2">
                           <img
                           src="/cosme/resources/productPhotoFiles/<%=p.getP_img3_changename()%>"
                           alt="" style="width: 100%;">
                        </li>
                     </ol>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <img class="d-block w-100"
                              src="/cosme/resources/productPhotoFiles/<%=p.getP_img1_changename()%>"
                              alt="First slide">
                        </div>
                        <div class="carousel-item">
                           <img class="d-block w-100"
                              src="/cosme/resources/productPhotoFiles/<%=p.getP_img2_changename()%>"
                              alt="Second slide">
                        </div>
                        <div class="carousel-item">
                           <img class="d-block w-100"
                              src="/cosme/resources/productPhotoFiles/<%=p.getP_img3_changename()%>"
                              alt="Third slide">
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <!--  이렇게 하면 서블릿으로 가겠죠?  -->
            <div class="col-lg-5 offset-lg-1" >
               <div class="s_product_text">
                     <form id="form" name="form"   method="get">
                     <h3><%=p.getP_name()%></h3>
                      <input type="hidden" name="p_name" value="<%=p.getP_name()%>">
                     <input type="hidden" name="p_no" value="<%=p.getP_no()%>">
                     
                     <ul class="list">
                              
                        <li><a class="active" href="#" id="">
                           <span>Category</span> :
                              
                              <%= ca1.getCa1_name() %> 
                              
                              </a></li>
                              
                        <li><a href="#"><span>Availibility</span> : In Stock</a></li>
                     </ul>
                     
                     
                     <div class="widgets_inner" style="padding-top: 15%; width : 80%; margin : 0 auto; display: block;">
                           <ul class="list" style="border-top : 1px dashed #ebebeb; border-bottom : 1px dashed #ebebeb; padding : 2% 0 2% 0;">
                              <li style="text-align : right;">
                                 <i class="fa fa-truck" aria-hidden="true" style="color : #c5322d;"></i>
                                 <a>일반 배송</a>
                                 <ul class="list">
                                    <li><a href="#"  style="font-size : 12px;">최종 결제금액이 <h7 style="color: #c5322d;">20,000</h7> 원 이상이면 무료로 배송됩니다.</a></li>
                                 </ul>
                              </li>
                              
                           </ul>
                           
                        
                           <ul class="list" style="border-bottom : 1px dashed #ebebeb; padding : 2% 0 2% 0;">
                              <li style="text-align : right;  ">
                                 <i class="fa fa-product-hunt" aria-hidden="true" style="color : #c5322d;"></i>
                                 <a>포인트 적립</a>
                                 <ul class="list">
                                    <li><a href="#"  style="font-size : 12px;">뷰티포인트 1% 적립예정</a></li>
                                 </ul>
                              </li>
                              
                           </ul>
                          </div>
                           
                     <div class="product_count" style="margin-top: 10%; display : block;">
                        
                  
                        <!--제품 수량  -->
                        <!-- amount도 수량이죠?? 네맞아요  그럼 input 태그니까 hidden이 아니어도 서블릿에 전달 하겠죠?? -->
                        수량 : <input type="hidden" id="product_price" name="p_price" value="<%=p.getP_price()%>"> 
                           <input type="button" value=" - " onclick="del();"> 
                           <input type="number" id="amount" name="amount" value="1" max="<%= p.getP_total_quantity() %>" size="3"
                           			 onchange="change();" style="text-align: center;" >
                           <input type="button" value=" + " max="<%= p.getP_total_quantity() %>" onclick="add();"> <br /> <br />
                           ￦  :  <input type="text" id="sum" name="sum" size="11" value="<%=p.getP_price()%>" style="border:0; font-size : 20px; width: 30%; text-align:center;"  readonly>원

                     </div>
                     <div class="card_area">  
                        <button onclick="buyBtn();" class="main_btn">BUY NOW</button>

                        <button onclick="addBtn();" class="main_btn">Add to Cart</button>

                        
                        <a class="icon_btn" href="#"><i class="lnr lnr lnr-heart"></i></a>
                     </div>
                        </form>
                        
                       <!-- 바로구매 / 장바구니 버튼 클릭 시 서블릿으로 넘기기  -->
                        <script>
                           function buyBtn(){
                              <%if(session.getAttribute("users")==null){%>
                                 alert("로그인 후 이용하세요");
                                 return false;
                              <%}else{%>
                              $('#form').attr("action", "<%=request.getContextPath()%>/pInsertBuy.pd");
                              <%}%>
                           }
                           
                           function addBtn(){
                              
                              <%if(session.getAttribute("users")==null){%>
                             alert("로그인 후 이용하세요");
                             return false;
                          <%}else{%>
                              
                              $("#form").attr("action", "<%=request.getContextPath()%>/pInsertBasket.pd");
                              <%}%>
                           }
                           
                           
                        </script>
                  
                  <!-- 이렇게 물품 수량만 보내 보도록 합시다. -->
                  <!-- 장바구니로 보낼 때 물품의 아이디하고 수량을 보내야 하죠? 
                       그럼 input으로 작성하는 건 모두 서블릿으로 갈 수 있으니 
                       input 한 번 확인 할게요!
                    -->
               </div>
            </div>
         </div>
      </div>
   </div>

   <!--================End Single Product Area =================-->

   <!--================Product Description Area =================-->
   <section class="product_description_area">
      <div class="container">
         <ul class="nav nav-tabs" id="myTab" role="tablist" >
            <li class="nav-item"><a class="nav-link active" id="home-tab"
               data-toggle="tab" href="#home" role="tab" aria-controls="home"
               aria-selected="true">성분 분석</a></li>
            <li class="nav-item"><a class="nav-link" id="review-tab"
               data-toggle="tab" href="#review" role="tab" aria-controls="review"
               aria-selected="false">리뷰</a></li>
            <li class="nav-item"><a class="nav-link" id="profile-tab"
               data-toggle="tab" href="#profile" role="tab"
               aria-controls="profile" aria-selected="false">같은 카테고리 상품</a></li>
         </ul>
         <!-- 제품 성분 분석 통계   -->
         <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="home" role="tabpanel"
               aria-labelledby="home-tab">
               <div class="infoList">
                  <div class="divtable" id="detail" style="cursor: pointer;">
                           <div  class="serial detail" >
                              <i class="fa fa-tint fa-2x" aria-hidden="true" style="font-size: 18px; padding-left: 2%;">
                              &nbsp;&nbsp;&nbsp;전성분 확인하기
                           </i>
                           <i class="fa fa-arrow-down" aria-hidden="true" style="float: right; padding-right: 2%;"></i>
                           <hr />         
                           </div>
                 </div>
                        <div id="faqDetail" style="display: none;">
                           <div>
                      <h3><%= br.getBr_name() %></h3>
                      <hr />
                            <h4><%= p.getP_name() %></h4> <br />
                                 <%= p.getP_ingredient() %>

                           </div>
                        </div>
                        
                        <script>  
                      $(".divtable").click(function(){
                           <%-- var f_no = $(this).parent().children().eq(0).text();
                           location.href="<%=request.getContextPath()%>/fSelectOneUsers.faq?f_no=" + f_no; --%>
                           if($(this).next().css("display") == "none") {
                              $(this).next().show('10000');
                              $(this).next().show();
                           } else {
                              $(this).next().hide();
                           }
                        });
                     </script>
               
                     
               
                  
                 
                  
               </div>
               
               <!-- <h5>제품상세보기이미지</h5> -->
               <img
                  src="/cosme/resources/productPhotoFiles/<%=p.getP_ex_changename()%>"
                  style="width: 80%;">
            </div>
            
            <!-- 카테고리 상품 -->
            <div class="tab-pane fade" id="profile" role="tabpanel"
               aria-labelledby="profile-tab">
               <div class="feature_product_inner container"style="margin-top: 5%;">
                  <div class="main_title">
                     <h3>같은 카테고리 상품</h3>
                  </div>
                  
                  <div class="feature_p_slider owl-carousel" style="cursor: pointer">

                     <%
                        for (Product p2 : list) {
                     %>
                     <div class="item">
                        <div class="f_p_item" >
                           <div class="f_p_img">
                              <img class="img-fluid"
                                 src="/cosme/resources/productPhotoFiles/<%=p2.getP_img1_changename()%>"
                                 alt="">
                              <div class="p_icon">
                                 <a href="#"><i class="lnr lnr-heart"></i></a> <a href="#"><i
                                    class="lnr lnr-cart"></i></a>
                              </div>
                           </div>
                           <input type="hidden" value="<%=p2.getP_no()%>" />
                           <h4><%=p2.getP_name()%></h4>
                           <h5><%=p2.getP_price()%></h5>
                        </div>
                     </div>
                     <%
                        }
                     %>


                  </div>
               </div>
            </div>
            <script>
                  /* 제품 선택시 제품 상세보기로 넘어가기 */
                  $(function(){
                     $(".f_p_item").click(function(){
                        var p_no = $(this).parent().find("input").val();
                        location.href="<%=request.getContextPath()%>/pInfo.pd?p_no="+ p_no;
                  });
               });
            </script>
            <!-- 리뷰 작성  =====================================================================-->
            <div class="tab-pane fade" id="review" role="tabpanel"
               aria-labelledby="review-tab">
               <div class="row">
                  <div class="col-lg-6" style= "height: 350px;">
                     <div class="row total_rate" style="padding-top: 15%;">
                        <div class="col-6">
                           <div class="box_total">
                              <h5>평점</h5> <br />
                              <h4><%= reStar.getR_star() %></h4>
                              
                           </div>
                        </div>
                        <!-- 별점 개수 불러오기  -->
                        <% 
                                       		int starCount1 = 0;
	                                        int starCount2 = 0;
	                                        int starCount3 = 0;
	                                        int starCount4 = 0;
	                                        int starCount5 = 0;
                                       	
                                       		for(ReviewStarCount rsCount : reStarCount){
                                       		
                                       		if(rsCount.getR_star()==1){
                                       			starCount1 = rsCount.getR_starcount();
                                       		}
											if(rsCount.getR_star()==2){
												starCount2 = rsCount.getR_starcount();                                   			
                                       		}
											if(rsCount.getR_star()==3){
												starCount3 = rsCount.getR_starcount();
                                       		}
											if(rsCount.getR_star()==4){
												starCount4 =  rsCount.getR_starcount();
                                       		}
											if(rsCount.getR_star()==5){
												starCount5 =  rsCount.getR_starcount();
                                       		}

                                       } %>
                        <div class="col-6">
                           <div class="rating_list">
                              <h3>Review Count</h3>
                              <ul class="list">
                                 <li><a href="#">
                                 
                                 
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>  &nbsp;
                                  <%= starCount5 %><br /> 
                                 </a></li>  
                                 <li><a>    
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star-o"></i> &nbsp;
                                  <%= starCount4 %> <br /> 
                                  </a></li>  
                                 <li><a>    
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i> &nbsp;
                                 <%= starCount3 %><br /> 
                                 </a></li>  
                                 <li><a> 
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i> &nbsp;
                                 <%= starCount2 %><br />     
                                  </a></li>  
                                 <li><a>     
                                 <i class="fa fa-star"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i>
                                 <i class="fa fa-star-o"></i> &nbsp;
                                 <%= starCount1 %><br />     
                                       
                                 </a></li>
                                 
                              </ul>
                           </div>
                        </div>
                     </div>
                  </div>
                  
                  <!-- 리뷰 작성하기 -->
                  <div class="col-lg-6"
                     style="width: 100%; height: 350px;">
                     <div class="review_box" style="float: right;">
                        <h3>리뷰 작성</h3>
                        <p style="font-size: 12px;">
                           REVIEW | <span>문의글 혹은 악의적인 비방글은 무통보 삭제되는 점 유의해주세요^_^</span>
                        </p>
                        <br> <br>
                        
                        <!-- 방금 form태그만 넣어봤습니다 . -->
                        <form class="row contact_form" name="review" action="/cosme/rInsert.re" style="margin:0;"
                        method="post" id="contactForm" novalidate="novalidate" enctype="multipart/form-data" onsubmit="return validate();">
                        
                           <!-- 별점 선택하기 form 태그 영역이였씁니다.  -->
                           <!--  .....?? 그 프로덕트 리스트 view 보시면 같은 select 태그있는데 판매순 정렬/가격순 정렬? 이것도 select문이 안먹히네요.. -->
                           <!-- 이거 셀렉트 문이 변하는데요..;; 
                               
                           -->
                            <select name="r_star" class="r_star" id="star" style="width: 50%;">
                              <option value="" >별점 선택하기</option>
                              <option value="5">★★★★★</option>
                              <option value="4">★★★★☆</option>
                              <option value="3">★★★☆☆</option>
                              <option value="2">★★☆☆☆</option>
                              <option value="1">★☆☆☆☆</option>
                           </select> <br> <br> 
                           <script>
                              function validate() {
                                 var id = document.getElementById("star");
                                 var id2 = document.getElementById("r_content");
                                 /* 리뷰 사진 등록시 null값  */
                                 /* var id3 = document.getElementById("attImage");
                                 var id33 = document.getElementById("reviewImg"); */
                                 
                                 if(id.value=="") {
                                       alert("별점을 선택해 주세요!");
                                       id.focus();
                                       return false;
                                 }
                                 else if (id2.value==""){
                                    alert("리뷰를 작성해 주세요!");
                                       id2.focus();
                                       return false;
                                 }
                              }
   
                           
                           </script>
                           <!-- <input type="text" id="result">  -->
                           <div class="col-md-12" style="padding : 0;">
                              <div class="form-group">
                                 <textarea class="form-control" name="r_content" id="r_content" value=""
                                   placeholder="내용을 입력해주세요."></textarea>
                              </div>
                           </div>
   
                           <input type="hidden" name="p_no" value="<%=p.getP_no()%>">
                           
                           
                           
                        
                           <div class="col-md-12 text-right" style="width:100%; padding: 0;">
                              <button value="" class="btn submit_btn" type="button" id="pImage" style="margin : 0;float:left; cursor: pointer;">
                              <i class="fa fa-camera" aria-hidden="true"></i> &nbsp; 사진 추가 +
                           </button>
                           <input type="file" name="file" id="attImage" value="">
                              <button id="reviewBtn" type="submit" value="submit" style="margin: 0; "
                                 class="btn submit_btn" >리뷰 등록하기</button>
                           </div>
                           
                           <p id="hideFile">리뷰 사진이 등록 되었습니다.</p>
                           
                           
                        </form>
                        <script>
                     // 로그인 X 리뷰작성 X
                        $('#reviewBtn').click(function(){
                            <%if(session.getAttribute("users")==null){%>
                             alert("로그인 후 이용하세요");
                             return false;
                          <%}else{%>
                          $('#form').attr("action", "<%=request.getContextPath()%>/rInsert.re");
                          <%}%>
                         });
                        
                           $(function() {
                              // 즉석 실행 함수 등록 // 리뷰사진 등록
                              $('#attImage').hide();
                              $('#hideFile').hide();
                              
                              $('#pImage').click(function() {
                                 $('#attImage').click();
                                 $('#hideFile').val();
                                 
                                 if(('#pImage') == null) {
                                	 ('#reviewImg').val().hide();
                                 }
                              
                              });
                           });
                           // 별점 js 기능 부분입니다.
                           $('#star').change(selectNation);

                           function selectNation() {

                              var value = $('option:selected').val();

                              $('#result').val(value + "별점의 개수입니다.");
                           }
                        </script>


                     </div>
                  </div>
                  
                  
                  <!-- 리뷰 조회하기  -->
                  
                           <%
                              for (Review r : rlist) {
                           %>
                  <div class="review_list" style="width : 100%;  ">


                        <div class="review_item">
                           <div class="media" style="border-bottom : 1px solid #e2e2e2 ;margin-top: 2%;">
                              <div class="media-body" style="margin : 2%; width : 30%; display: block;"  >
                                 
                                 <% for(int i = 1; i < 6 ; i++) {
                                    if(i <= r.getR_star()) { %>
                                    <i class="fa fa-star fa-2x"></i>
                                 <% } else { %>
                                 <i class="fa fa-star-o fa-2x"></i>
                                 <% } } %>
                                  <br /><br />
                                 <h5>작성자 : <strong> <%=r.getU_id()%></strong> <br /></h5> 
                                 <h5> <%=r.getR_date()%></h5>
                              <div class="d-flex" >
                                 <img width="25%"
                                    src="/cosme/resources/img/product/single-product/user_icon.png"
                                    alt="">
                              </div>
                              </div> 
                              <br />
                               <table style = "width : 70%; ">
                                 <tr>
                                    <td style="width : 30%; padding : 5% 0; "> 
                                    <% if (r.getReviewfile() != null) { %>
                                    <img style="width:100%;" id="reviewImg" src="/cosme/resources/ReviewUploadFiles/<%=r.getReviewfile()%>">
                                    <% } else { %>
                                    	<img width="100%" src="/cosme/resources/img/noimage.gif" alt="" />
                                    <% } %>
                                    </td>
                                    <td style="padding : 5% 5%;"><i class="fa fa-quote-left fa 2x" aria-hidden="true"></i> &nbsp;&nbsp;
                                    <%=r.getR_content()%>&nbsp;&nbsp;  <i class="fa fa-quote-right fa 2x" aria-hidden="true"></i> </td>
                                 </tr>
                              </table> 
                              
                               
                           </div>
                        </div>
                     </div>
                           <%
                              }
                           %>

               </div>
            </div>
         </div>
      </div>
      
   </section>


   <!--================End Product Description Area =================-->
   <!-- 스크롤 -->
   <a id="TopButton" class="ScrollButton"><i class="fa fa-arrow-circle-up fa-2x" aria-hidden="true"></i></a>
   <a id="BottomButton" class="ScrollButton"><i class="fa fa-arrow-circle-down fa-2x" aria-hidden="true"></i></a>
   
   
   <script>
   <!-- 스크롤 js -->
   $(function() {
       $(window).scroll(function() {
           if ($(this).scrollTop() > 600) {
               $('.ScrollButton').fadeIn();
           } else {
               $('.ScrollButton').fadeOut();
           }
       });
           
       $("#TopButton").click(function() {
           $('html').animate({scrollTop : 0}, 600);
       });
    
       $("#BottomButton").click(function() {
           $('html').animate({scrollTop : ($('#footer').offset().top)}, 600);
       });
   });

   </script>
   
   
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>

   <script>
   /* 별점 선택하기 실행 */
   $('#star').niceSelect();
   
   $('.owl-carousel').owlCarousel({
       loop:true,
       margin:10,
       nav:true,
       responsive:{
           0:{
               items:1
           },
           600:{
               items:3
           },
           1000:{
               items:5
           }
       }
   });
   
   
   </script>
   
   <a id="footer"></a>
   
   <%@ include file="/views/users/common/footer.jsp"%>
   
<!-- 제품 수량  js 부분이고요-->
   <script>
      var sell_price;
      var amount;
      
      function init () {  // 이거 필요 없을 것 같아요;; 일단 원인 부터 해결 해볼게요 
        sell_price = document.form.sell_price.value;
        amount = document.form.amount.value;
        document.form.sum.value = <%=p.getP_price()%>;
        change();
      }
   
      function del () { // 수량 감소 함수 
         if($('#amount').val() > 1) {
            var price_one = Number($('#product_price').val()); // 한 개 가격
             var amount_product = Number($('#amount').val()) - 1; // 수량 한 개 감소!
             var sum_product = price_one * amount_product;

             console.log(price_one); 
             console.log(amount_product); 
             console.log(sum_product); 
            
             $('#amount').val(amount_product); 
             $('#sum').val(sum_product);
         } else {
            alert("최소 1개 이상 주문하셔야 합니다 ^_^");
         } 
         
          
      }
      function add() { // 수량 증가 함수
         
         var price_one = Number($('#product_price').val()); // 한 개 가격
         var amount_product = Number($('#amount').val()) + 1; // 수량 한 개 증가!
         var sum_product = price_one * amount_product;
         var max = <%= p.getP_total_quantity() %>;
         
         $('#amount').val(amount_product);
         $('#sum').val(sum_product);
         
         /* 제품 수량에 맞춰서 제한 */
         if($('#amount').val() > max){
            alert("제품 재고 수량이 " + max + " 개로 제한되었습니다. 수량을 다시 선택해 주세요.");
            $('#form')[0].reset();
         }
         
       }
      
      function change () {
        hm = document.form.amount;
        sum = document.form.sum;
      
          if (hm.value < 0) {
            hm.value = 0;
          }
          sum.value = parseInt(hm.value) * <%=p.getP_price()%>;
      }  
      
      </script>

</body>
</html>



h2 {
   color: #1f76bc;
}

.width {
   width: 2000px;
}
/* 상품 상세 */
.product_info {
   padding: 100px 0 135px;
   background: white;
}

.product_pictures {
   text-align: center;
   position: relative;
}

.product_pictures .thumb_img {
   margin-top: 70px;
   display: flex;
   justify-content: center;
}

.product_pictures .thumb_img li {
   padding: 12px 0;
   text-align: center;
   background: white;
   display: flex;
   align-items: center;
   justify-content: center;
   position: relative;
}

.product_pictures .thumb_img li img {
   width: 70px;
   height: 70px;
   margin-left: 25px;
   margin-right: 25px;
}

form hr {
   border: none;
   border-top: 1px solid #edeff1;
   margin-top: 15px;
   margin-bottom: 15px;
   margin-right: 45px;
}

.option h4 {
   display: inline-block;
   font-weight: 600;
   font-size: 18px;
   margin-right: 20px;
}

.option .size input {
   display: none;
}

.option .size label {
   font-size: 14px;
   transition: 0.3s;
   cursor: pointer;
}

.quantity span {
   cursor: pointer;
}

.option .size input:checked+label {
   font-size: 18px;
   font-weight: 600;
   color: #1f76bc;
}

.option .quantity input {
   border: none;
   width: 30px;
   color: #1f76bc;
   font-weight: 600;
   text-align: center;
   font-size: 18px;
}

.order_summary h4, button {
   display: inline-block;
   font-weight: 600;
   font-size: 18px;
   margin-right: 20px;
}

.order_summary button {
   margin-top: 20px;
   cursor: pointer;
}

.total_price .price {
   display: inline-block;
   font-weight: 600;
   font-size: 18px;
   margin-right: 4px;
   color: #1f76bc;
}

.buybtn {
   padding: 0 24px;
   height: 40px;
   color: white;
   font-size: 18px;
   font-weight: 600;
   background: #1f76bc;
   border-radius: 25px;
   border: none;
}

.product_pictures .thumb_img li:before {
   content: "";
   position: absolute;
   left: 0;
   right: 0;
   bottom: 0;
   top: 0;
   background: #F5F6CE;
   opacity: 0;
   transition: 0.3s;
   cursor: pointer;
}

.product_pictures .thumb_img li.active:before {
   opacity: 1;
}

.product_pictures .thumb_img li.active img {
   opacity: 0.3;
}