<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<script>
$(function(){
	$("table").on('click','tr',function(){
		var trid = $(this).attr('id');
		var trname = $(this).attr('name');
		var trnum = document.getElementById("num").value;
		msg = trname+"님을 삭제하시겠습니까?";
		if(confirm(msg)!=0){
			// Yes시 동작하는 기능
			
			ajaxDelete(trid,trnum);
			
		} else{
			// No시 동작하는 기능
		}
		

			
		
	})//테이블 클릭 이벤트
	
	
	 $('#updateBtn').on("click",function(e){
			var startDay = document.getElementById("startDay").value
			var endDay = document.getElementById("endDay").value
			
				if(!document.getElementById("name").value){
					alert("과제명을 입력하세요");
					return false;
				}
				if(!startDay){
					alert("시작일을 입력하세요");
					false;
					return false;
				}
				if(!endDay){
					alert("종료일을 입력하세요");
					false;
					return false;
				}			
				
				//날짜 확인
				startDate = startDay instanceof Date ? startDay : new Date(startDay);
				endDate = endDay instanceof Date ? endDay : new Date(endDay);
				var days = startDate<endDate?true:false; //시작일이 종료일보다 작으면 true
						
				if(days){
					var formData = {
							"num" : document.getElementById("num").value, 
							"name" : document.getElementById("name").value, 
							"startDay" : document.getElementById("startDay").value,
							"endDay" : document.getElementById("endDay").value }
					
					ajaxUpdate(formData)//insert작업
				}else{
					alert("시작일이 종료일보다 빨라야합니다.");
				}
				
	 });//클릭이벤트종료 
	 $('#insertBTN').on("click",function(e){
		 console.log("클릭^^!");
		 windowOpen();
	 })//유저추가버튼이벤트
	 
});

function ajaxUpdate(formData){
	$.ajax({
			url: "taskUpdateDB.do",
			type: "post",
			data: JSON.stringify(formData),
			contentType :"application/json"
		})
		.done(function (data, textStatus, xhr) {
	       if(data.chk>0){
	           alert("과제정보가 수정되었습니다.");
	       } else if(data==0) {
	    	   alert("실패하였습니다, 관리자에게 문의하십시오.");
	       } else{
	    	   alert("중복된 이름이 있습니다.");
	       }
	}); // AJAX DONE닫기
}
function windowOpen(e){
	//현재 페이지 이름
	window.name ="parentForm";
	//open할 자식 페이지 이름
	var openWin = window.open("openInfo.do?num="+document.getElementById("num").value,"childForm", "width=500,height=600,toolbar=no, menubar=no, scrollbars=yes, resizable=yes");	
}



function ajaxDelete(trid,trnum){
	//ajax로 insert 처리하기 
			var formData = {
					"num" : trnum, 
					"id" : trid
			};
		console.log("삭제합니다");
		console.log(formData);
		$.ajax({
			url: "listDeleteDB.do",
			type: "post",
			data: JSON.stringify(formData),
			contentType :"application/json"
		})
		.done(function (data, textStatus, xhr) {
			 console.log(xhr);
			 if(data.chk>0){
				 alert("사용자가 삭제되었습니다.");
				 location.reload();
             } else {
                 alert("실패하였습니다, 관리자에게 문의하십시오. ");
                 location.reload();
             }
         }); // AJAX DONE닫기
			
}//ajax닫기
</script>
<body>

	<jsp:include page="header.jsp" />
	
 	<div class="container divCenter" style="height: 1000;">
	    <div class="card border-info">
        	<div class="card-body">
        	     <h3 style="text-align:left">과제정보</h3>
        	     <hr>
        	     <p>
        		<form>
        		<input type="text" style="display:none" id="num" name="num" value="${param.num}"/>
        		 <div class="form-group row">
				    <label for="name" class="col-sm-2 col-form-label">과제명</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="name" name="name" value="${name}">
				     </div>
				 </div>
				 <div class="form-group row">
				    <label for="date" class="col-sm-2 col-form-label">과제기간</label>
				    <div class="col-sm-4">
				     <input type="date" class="form-control" id="startDay" name="startDay" value="${startDay }">
				     </div>
				      ~
				     <div class="col-sm-5">
				     <input type="date" class="form-control" id="endDay" name="endDay" value="${endDay }"/>
				    </div>
				  </div>
				  <input type="button" id="updateBtn" class="btn btn-sm btn-secondary" value="수정">
				</form>
				<p/>
				<form>
					<table class="tableCenter table-hover">
						 <tr>
			                <th>No</th>
			                <th>사용자ID</th>
			                <th>사용자명</th>
			            </tr>
			            <c:forEach items="${list }" var="list" varStatus="stNum">
			              <tr id=${list.id } name=${list.name }>
			            	<td>${stNum.count }</td>
							<td>${list.id }</td>
			            	<td>${list.name }</td>
			         	  </tr>
			            </c:forEach>
					</table>
					<input type="button" id="insertBTN" class="btn btn-sm btn-secondary" value="사용자추가">	
				</form>
	        </div>
        </div>
    </div>
</body>
</html>