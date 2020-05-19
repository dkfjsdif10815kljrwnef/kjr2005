<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
		
		
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
          .table-mar {
          	margin-top : 25px;
          	margin-bottom : 15px;
          }
          .hiden{
          	display: none 
          }
         </style>
</head>
<body>
	<div id="div" class="headerCenter">
		<a class="btn btn-outline-info" onclick="location.href='userList.do'">사용자목록</a>
		 &nbsp; | &nbsp;
		<a class="btn btn-outline-info" onclick="location.href='taskList.do'">과제목록</a>
	</div>
</body>
</html>