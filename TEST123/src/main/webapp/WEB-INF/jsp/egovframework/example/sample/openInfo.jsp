<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		$("table").on('click','tr',function(){
			var trnum = $(this).attr('name');
			var trid = $(this).attr('id');
			
			ajaxInsert(trnum,trid);
			
		})//테이블 클릭 이벤트
	});
	
	
	
	//ajax로 insert 처리하기 
	function ajaxInsert(trnum,trid){
			var formData = {
					"num" : trnum, 
					"id" : trid
			}
		
			$.ajax({
				url: "listInsertDB.do",
				type: "post",
				data: JSON.stringify(formData),
				contentType :"application/json"
			})
			.done(function (data, textStatus, xhr) {
				 console.log(xhr);
				 if(data.chk>0){
					 alert("사용자가 추가되었습니다.");
                     window.opener.location.reload();
                     window.close();
                 } else {
                     alert("실패하였습니다, 관리자에게 문의하십시오. ");
                     window.opener.location.reload();
                     window.close();
                 }
             }); // AJAX DONE닫기
		}//ajaxInsert함수닫기

	
	
	
	
	
	
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize,num) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
	
			var url = "openInfo.do";
			
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			url = url + "&num=" + num;
			location.href = url;
		}


		
	  //페이지 번호 클릭
	
		function fn_pagination(page, range,num) {
		
			var url = "openInfo.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			url = url + "&num=" + num;
			console.log(url);
			location.href = url;	
		}
	
	
	
		//다음 버튼 이벤트
	
		function fn_next(page, range, rangeSize,num) {
	
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
	
			var url = "openInfo.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			url = url + "&num=" + num;
			location.href = url;
		}
	</script>
	<style>
	
		 .headerCenter {
                text-align: center;
                margin: auto;
                margin-top : 30px;
                margin-bottom : 30px;
            }
            
          .divCenter {
                text-align: center;
                margin: auto;
            }
             .tableCenter {
                width: 60%;
                 margin:auto;
                 text-align: center
          }
		 .page-item {
		 	margin:1px;
		 }
	</style>
</head>
<body>

<div class="container divCenter" style="height: 1000;">
<div class="headerCenter"><input type="text" style="display:none" id="num" name="num" value="${num}"/></div>

	    <div class="card border-info">
        	<div class="card-body">
        	    <h3 style="text-align:left">사용자 목록</h3>
        	    <hr>
        		<form>
					<table class="tableCenter table-hover">
						 <tr>
			                <th>No</th>
			                <th>ID</th>
			                <th>사용자명</th>
			            </tr>
			            <c:forEach items="${list }" var="list" varStatus="stNum">
			              <tr id="${list.id }" name="${num}">
			            	<td>${stNum.count }</td>
			            	<td>${list.id }</td>
			            	<td>${list.name }</td>
			         	  </tr>
			            </c:forEach>
			            
					</table>
				</form>
				 <!--페이징처리영역 -->
         		 <!-- pagination{s} -->
				<div id="paginationBox" style="display:inline-block">
			
					<ul class="pagination">
						<c:if test="${pagination.prev}">
							<li class="page-item">
								<a style="padding:3px;" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}','${num}')">≪</a></li>
						</c:if>
							
			
						<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
							<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
								<a href="#" onClick="fn_pagination('${idx}', '${pagination.range}','${num}')"> ${idx} </a></li>
						</c:forEach>
			
			
						<c:if test="${pagination.next}">
							<li class="page-item">
								<a href="#" onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}','${num}')" >≫</a>
							</li>
						</c:if>
			
					</ul>
				</div>
<!-- pagination{e} -->



         		 
         		 
         		 
	        </div>
        </div>
    </div>
</body>
</html>