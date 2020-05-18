<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	
	<style>
	.child {
	    display: inline-block;
	    margin-top : 250px;
	}
	 .divCenter {
                text-align: center;
                margin: auto;
            }
	</style>
<title>Insert title here</title>
	<script>
	 $(function(){
		$("#btn").on("click",function(){
			var idData = document.getElementById("loginID").value
			var formData = {
					"loginID" : idData, 
			}
			console.log(formData);
			$.ajax({
				url: "idchkDB.do",
				type: "post",
				data: JSON.stringify(formData),
				contentType :"application/json"
			}) //AJAX닫음
			.done(function (data, textStatus, xhr) {
                    if(data.cnt=="0"){
                    	 alert("다시 시도하십시오.");
                    	 location.href="login.do";
                    }else{
                    	alert("로그인 되었습니다. ");
                        location.href="userList.do";
                    }  
             }) //done닫음
             .fail(function(){
            		 alert("관리자에게 문의하세요.");
             }); //fail닫음
			
			
		}) //버튼 클릭이벤트닫음
	}) //스크립트닫음
	</script>
</head>
<body>
	<div class="container divCenter" style="width: 800;height: 1000;">
	    <div class="card child" style="width:800; height:500">
        	<div class="card-body">
		        <form id="frm" action="userList.do" method="post">
		            id : 
		            <input alt="id" id="loginID" name="loginID" value="">
		            <input type="button" id="btn" value="로그인">
		        </form>
	        </div>
        </div>
    </div>
</body>
</html>