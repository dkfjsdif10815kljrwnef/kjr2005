<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
   <script>
   $(function(){
	   $('#btn').on("click",function(e){
	       //serialize() jquery api 메소드를 이용해서 form 의 모든 element의 
	       //name과 value 값을 넘길수 있음!!  
			var nameData = document.getElementById("name").value
			var startDay = document.getElementById("startDay").value
			var endDay = document.getElementById("endDay").value
	       
			if(!nameData){
				alert("과제명을 입력하세요");
				return false;
			}
	       
			if(!startDay){
				alert("시작일을 입력하세요");
				return false;
			}
			if(!endDay){
				alert("종료일을 입력하세요");
				return false;
			}
			
			startDate = startDay instanceof Date ? startDay : new Date(startDay);
			endDate = endDay instanceof Date ? endDay : new Date(endDay);
			var days = startDate<endDate?true:false; //시작일이 종료일보다 작으면 true
					
			if(days){
				var formData = { "name" : nameData,		"startDay" : startDay,			"endDay" : endDay }
				ajaxInsert(formData)//insert작업
			}else{
				alert("시작일이 종료일보다 빨라야합니다.");
			}
			
			
			
			
	   });//클릭이벤트종료 
   })
   
   function ajaxInsert(formData){
	    $.ajax({
   			url: "taskInsertDB.do",
   			type: "post",
   			data: JSON.stringify(formData),
   			contentType :"application/json"
   		})
   		.done(function (data, textStatus, xhr) {
               console.log(xhr);
               if(data.chk>0){
                   alert("과제가 입력되었습니다.");
                   location.href="taskInfo.do?num="+data.num;
               } else if(data==0) {
            	   alert("실패하였습니다, 관리자에게 문의하십시오.");
                   location.href="taskInsert.do";
               } else{
               		alert("중복된 과제명이 존재합니다.")
               }
         }); // AJAX DONE닫기
   }
   </script>
</head>
<body>

	<jsp:include page="header.jsp" />
	
 	<div class="container divCenter" style="height: 1000;">
	    <div class="card border-info">
        	<div class="card-body">
        	     <h3 style="text-align:left">과제입력</h3>
        	     <hr>
        	     <p>
        		<form id="frm" method="post" action="taskInsertDB.do">
	        		 <div class="form-group row">
					    <label for="name" class="col-sm-2 col-form-label">과제명</label>
					    <div class="col-sm-9">
					     <input type="text" class="form-control" id="name" name="name" path="name" value="${name }" />
					    </div>
					 </div>
					 
					 <div class="form-group row">
					    <label for="date" class="col-sm-2 col-form-label">과제기간</label>
					    <div class="col-sm-4">
					      <input type="date" class="form-control" id="startDay" name="startDay" value="${startDay } path="startDay"/>
					    </div>
					      ~
					    <div class="col-sm-4">
					      <input type="date" class="form-control" id="endDay" name="endDay" value="${endDay } path="endDay"/>
					    </div>
					  </div>
				 	 <input type="button" id="btn" class="btn btn-sm btn-secondary" value="입력">
				</form>
				<p/>
	        </div>
        </div>
    </div>
 
 
</body>
</html>