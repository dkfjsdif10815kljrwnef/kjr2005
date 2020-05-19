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
		 
		 
		 
		$("#btn").on("click",function(){
			var idData = document.getElementById("id").value
			var nameData = document.getElementById("name").value
			if(!nameData){
				alert("이름을 입력하세요");
				false;
				return false;
			}
			if(idNamesCheck(nameData)){
				ajaxInsert(idData,nameData);
			}
			
		});//btn 클릭이벤트 닫음
		
		
		
		function idNamesCheck (nameData) {  
		    // 정규표현식으로 한글만 선택하도록 만듭니다.
		    var krCheck = /^[가-힣]{1,10}$/; //이름조건
		    
		    //이름체크
		    if (krCheck.test(nameData)) {
		    	 return true;
			} else{
			    	$("#name").addClass("is-invalid");
			    	$("#msgName").removeClass("invalid-feedback");
			    	return false;
			 }
		    
		}
		
		
		
		
		function ajaxInsert(idData,nameData){
			var formData = {
					"ID" : idData, 
					"NAME" : nameData
				}
				$.ajax({
					url: "userUpdateDB.do",
					type: "post",
					data: JSON.stringify(formData),
					contentType :"application/json"
				}) //ajax닫기
				.done(function (data, textStatus, xhr) {
					console.log(xhr);
	                if(data.chk>0){
	                    alert("내용이 변경되었습니다.");
	                    location.href="userList.do";
	                    
	                } else {
	                    alert("다시 시도하십시오."+data.ID);
	                    //location.href="userInfo.do?ID="+data.ID+"&NAME="+data.NAME;
	                }
					
		        });//done닫기		
		}//
		
		
	  });//마지막닫기
	</script>
	
</head>
<body>
 	<jsp:include page="header.jsp" />
 	<div class="container divCenter" style="height: 1000;">
 	      
	    <div class="card border-info">
        	<div class="card-body">
        	     <h3 style="text-align:left">사용자 정보</h3>
        	      <hr>
        	     <p>
        		<form id="frm" >
        		 <div class="form-group row">
				    <label for="id" class="col-sm-2 col-form-label">id</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="id" name="ID"value="${ID }" readonly>
				     </div>
				 </div>
				 <div class="form-group row">
				    <label for="name" class="col-sm-2 col-form-label">이름</label>
				    <div class="col-sm-9">
				      <input type="text" class="form-control" id="name" name="NAME" value="${NAME }">
				     </div>
				 </div>
				 <div id="msgName" class="invalid-feedback" style="color:red; margin-bottom:8px;">
					  	이름은 10글자 내외 한글로만 입력해주세요.
				 </div>
				 <c:set var="loginId" value="${loginId }" />
				 <c:set var="id" value="${ID }" />
				 <c:if test="${loginId eq id  }">
				 <input  id="btn" class="btn btn-sm btn-secondary" type="button" value="수정">
				 </c:if>
				</form>
			</div>
        </div>
    </div>
 
 
</body>
</html>