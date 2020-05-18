<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script>
	$(function(){
		$("table").on('click','tr',function(){
			var trNum = $(this).attr('id');
			if(!trNum){
				console.log("제목");
			}else{
				location.href="taskInfo.do?num="+trNum;
			}
		})//테이블 클릭 이벤트
		
		
	});
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {

			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
	
	
			var url = "taskList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
	
			location.href = url;
		}


		
	  //페이지 번호 클릭
	
		function fn_pagination(page, range, rangeSize) {
	
			var url = "taskList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			location.href = url;	
		}
	
	
	
		//다음 버튼 이벤트
	
		function fn_next(page, range, rangeSize) {
	
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
	
			var url = "taskList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			location.href = url;
		}
	</script>
</head>

<body>

 	<jsp:include page="header.jsp" />
 	
 	<div class="container divCenter" style="height: 200;">
	    <div class="card border-info">
        	<div class="card-body">
        	 <input type="button" class="btn btn-sm btn-secondary"value="추가" onclick="location.href='taskInsert.do'" style="float: right;">
        	 <h3 style="text-align:left">과제목록</h3>
       	 	 <hr>
       	 	
			 <p/>
			 <form>
			
				<table class="tableCenter table-hover">
					 <tr>
		                <th>No</th>
		                <th>과제명</th>
		                <th>기간</th>
		            </tr>
					<c:forEach items="${list }" var="list" varStatus="stNum">
			              <tr id="${list.num }" name="${list.num }">
			            	<td>${stNum.count }</td>
			            	<td>${list.name }</td>
			            	<td>${list.startDay } ~ ${list.endDay }</td>
			         	  </tr>
			         </c:forEach>			            
				</table>
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
			 </form>
	        </div>
        </div>
    </div>
 
</body>
</html>