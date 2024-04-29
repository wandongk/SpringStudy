<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="jumbotron">
		<h1>빅데이너 23차 게시판</h1>
		<p>bootstrap 사용하여 간단하게 게시판을 만들어보자</p>
	</div>

	<div class="container">
		<div class="card">
			<div class="card-header">게시글 등록</div>
			<div class="card-body">
					<div class="form-group">
						<label for="title">제목:</label> 
						<td>${list.title}</td>
					</div>
					<div class="form-group">
						<label for="username">작성자:</label> 
						<td>${list.writer}</td>
					</div>
					<div class="form-group">
						<label for="comment">내용:</label>
						<td>${list.content}</td>
					</div>
					<div class="form-group">
						<label for="comment">작성일:</label>
						<td>${list.indate}</td>
					</div>
					<button onclick="location.href='${cpath}/edit/${list.idx}'" class="btn btn-primary">수정</button>
					<button onclick="location.href='${cpath}/delete/${list.idx}'" class="btn btn-primary">삭제</button>
					<button onclick="location.href='${cpath}/'" class="btn btn-primary">리스트</button>
			</div>
		</div>
	</div>

</body>
</html>