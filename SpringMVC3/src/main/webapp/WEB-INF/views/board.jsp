<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- 수정을 최소화 하기위한 변수정의 -->
<!-- == /controller -->
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
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
<!-- 자동완성 기능을 위해 가져온 jquery ui library -->	
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>	
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/smoothness/jquery-ui.css">

<!-- Chart를 그리기 위해 가져오는 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 차트에 폰트를 넣는 플러그인 -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

</head>
<body>
	<div class="jumbotron">
		<h1>빅데이터 23차 게시판</h1>
		<p>bootstrap 사용하여 간단하게 게시판을 만들어보자</p>
	</div>

	<div class="container">
		<div class="card">
			<div class="card-header">게시판 연습</div>
			<div class="card-body">
			
			<form onsubmit="return false;" class="form-inline" id="searchForm">         
           <div align="right" class="form-group" >
              <select name="type" class="form-control btn-warning" id="sel1">
                <option class="btn-light">작성자</option>
                <option class="btn-light">제목</option>
              </select>
           </div>
              <input id="auto_complete" name="text" type ="text" class="form-control">
              <input id="searchBtn" type="submit" class="btn btn-warning" value="검색" >
              </form>
           <br>
			
				<table id="myTable" class="table table-hover">
					<tr id="aabb">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일</td>
					</tr>

					<!-- JSTL/EL 사용하여 request 영역안에 저장돼있는 게시글 정보 전부 화면에 출력 -->
					<c:forEach var="list" items="${list}">
						<tr>
							<td>${list.idx}</td>
							<!--  1. QueryString으로 데이터 보내기 '${cpath}/boardContent?value=${list.idx}'
								2. 경로상에 그냥 바로 데이터 포함해서 보내기 -->
							<td><a href ='${cpath}/boardContent/${list.idx}'>${list.title}</a></td>
							<td>${list.writer}</td>
							<td>${list.indate}</td>
						</tr>
					</c:forEach>
				</table>
				<!-- 경로는 /controller/register거나 register로  -->
				<button onclick="location.href='${cpath}/register'" class="btn btn-primary">글쓰기</button>
				<button class="btn btn-success btn-sm chartBtn">차트보기</button>
			</div>
			<div class="card-footer myChartArea" style="text-align : center;">
				<canvas id="myChart" style="width : 500px; height : 500px; display : inline"></canvas>
			</div>
			
		</div>
	</div>
	
	<script type="text/javascript">
		var cpath = "${cpath}";
	</script>

	
	<script>
		// 1. 첫 실행시, myChartArea영역을 숨겨놓기
		$(".myChartArea").hide();
		// 2. 차트보기 버튼을 클릭하면, myChartArea영역을 보여주기
		$(".chartBtn").on("click",function(){
			// if($(".myChartArea").css("display") == "none")
			if($(".myChartArea").is(":hidden")) {
				// myChartArea영역이 숨겨져 있다면, 영역을 보여주기
				$(".myChartArea").slideDown();
				// 비동기 통신을 사용해서  /artist url로 데이터 요청
				// --> 언급된 빈도수가 가장 높은 상위 5명에 대한
				// 	   아티스트명과, 빈도수 데이터를 결과값으로 받아와서
				//     차트를 그려주세요.
			
				$.ajax({
					url : `${cpath}/artist`,
					dataType : "json",
					success: function(res){
						console.log("받아온 결과값 >> ", res);
						// 라벨, 데이터 생성
						var lables = [];
						var datas = [];
						for(var i = 0; i < res.length; i++){
							lables.push(res[i].artist);
							datas.push(res[i].keywordCnt);
						}
						
						drawChart(lables, datas);
					},
					error : function(e){
						console.log(e);
					}
				})
			}else{
				// canvas 삭제하고
				$("#myChart").remove();
				// 다시 새로운 canvas 추가하기
				$(".myChartArea").append('<canvas id="myChart" style="width : 500px; height : 500px; display : inline"></canvas>');
				// 그렇지 않은경우, 영역을 위로 올리면서 숨겨주기!
				$(".myChartArea").slideUp();
				}
		})
		
		function drawChart(lables, datas){
			// 1. 차트를 그릴 canvas 태그를 선택
			var ctx = $("#myChart");
			const data = {
					// DB에서 조회한 아티스트명으로 변경
					  labels: lables,
					  datasets: [{
					    label: 'My First Dataset',
					    // DB에서 조회한 키워드 빈도수로 변경
					    data: datas,
					    backgroundColor: [
					      '#ffbe0b',
					      '#fb5607',
					      '#ff006e',
					      '#8338ec',
					      '#3a86ff'
					    ],
					    hoverOffset: 4
					  }]
					};
			const options = {
					// 차트를 상대적인 크기가 아니라, 내가 원하는 크기로 지정하는 방법
					// position : relative 속성을 풀어주는 방법
					responsive : false,
					// 따로 설치한 플러그인 사용하기 
					plugins : {
						datalabels : {
							color : [
								"white",
								"white",
								"white",
								"black",
								"black",
							],
							formatter : function(v, c){
								// v랑 c가 의미하는 건 뭘까 ?
								console.log("f확인 >> ", v);
								console.log("c확인 >> ", c);
								// c 출력해서 구조 확인해보기!!
								// chart 종류마다 구조가 다름.
								return c.chart.data.labels[c.dataIndex]
							},
							font : {
								size : 20
							}
							
							
						}
					}
			};
			const config = {
					plugins : [ChartDataLabels],
					  type: 'pie',
					  data: data,
					  options : options
					};
			// 2. 차트 그리기 
			// new Chart(차트영역, 객체형식으로 된 차트의 옵션들)
			new Chart(ctx, config)
		}
	
	</script>

	<script src="resources/JS/myfirstjs.js"> </script>
</body>




</html>