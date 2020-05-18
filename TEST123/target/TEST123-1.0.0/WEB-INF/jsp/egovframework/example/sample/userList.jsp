<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
	$(function(){
		$("table").on('click','tr',function(){
			var trId = $(this).attr('id');
			var trName = $(this).attr('name');
			if(!trName){
				console.log("제목");
			}else{
				console.log(trId);
				console.log(trName);
				location.href="userInfo.do?ID="+trId+"&NAME="+trName;
			}
		})//테이블 클릭 이벤트
	});
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {

			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
	
	
			var url = "userList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
	
			location.href = url;
		}


		
	  //페이지 번호 클릭
	
		function fn_pagination(page, range, rangeSize) {
	
			var url = "userList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			location.href = url;	
		}
	
	
	
		//다음 버튼 이벤트
	
		function fn_next(page, range, rangeSize) {
	
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
	
			var url = "userList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			location.href = url;
		}
	</script>
	<style>
	 .page-item {
	 	margin:1px;
	 }
	</style>
</head>
<body>     
 	<jsp:include page="header.jsp" />
 	<div class="container divCenter" style="height: 1000;">
	    <div class="card border-info">
        	<div class="card-body">
        	 	<input type="button" class="btn btn-sm btn-secondary" value="추가" onclick="location.href='userInsert.do'" style="float: right;">
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
			              <tr id="${list.id }" name="${list.name }">
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
								<a style="padding:3px;" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">≪</a></li>
						</c:if>
							
			
						<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
							<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
								<a href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>
						</c:forEach>
			
			
						<c:if test="${pagination.next}">
							<li class="page-item">
								<a href="#" onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" >≫</a>
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