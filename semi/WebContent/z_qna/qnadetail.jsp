<%@page import="dto.MemberDto"%>
<%@page import="dto.QnaDto"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
if(mem == null){
%>  
	<script>
	alert("로그인 해 주십시오.");
	location.href = "<%=request.getContextPath()%>/z_login/login.jsp";
	</script>	
<%
}
%>

<%
String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);
%>
<%
request.setCharacterEncoding("utf-8");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>QNA 상세화면</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/all.css">

<style type="text/css">
.wrap {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.button {
  width: 80px;
  height: 35px;
  font-family: 'Roboto', sans-serif;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: dark;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: orange;
  box-shadow: orange;
  color: #fff;
  transform: translateY(-7px);
}
</style>
</head>

<%
QnaDao dao = QnaDao.getInstance();
dao.readcount(seq);
QnaDto dto = dao.getQnaInfo(seq);
%>

<br>
<br>
<body>
<input type = "hidden" value = <%=dto.getSeq() %>>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script> 
	<div align="center" class="list">
	<h1><img src = "<%=request.getContextPath() %>/image/qnalogo.png"></h1>
		<table class = "table table-hover">
			<col width="200px">
			<col width="500px">
			<tr>
				<th>작성자</th>
				<td><%=dto.getNickname()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><%=dto.getWdate().substring(0,16)%></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getReadcount()%>회</td>
			</tr>
			<tr>
				<th>이 글에 달린 답글</th>
				<%if(dto.getStep()==0){ %>
				<td><%=dao.getReQna(dto.getRef(), dto.getSeq())-1%>개</td>
				<%}else{ %>
				<td>0개</td>
				<%} %>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=dto.getContent()%></td>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<div class="buttons" align="center">
		<table>
			<tr colspan="2">

				<button type="button" class = "button"
					onclick="location.href='<%=request.getContextPath()%>/index.jsp?toss=z_qna/qnalist'">글목록</button>
				&nbsp;
				<%if(dto.getNotice()!=1){%>
				<button type="button" class = "button"
					onclick="answerqna(<%=dto.getSeq()%>)">답글</button><%} %>
				&nbsp;
				<%if(mem!=null&&(mem.getAuth()==1||(mem.getNickname().equals(dto.getNickname())))){ %>
				<button type="button" class = "button"
					onclick="updateqna(<%=dto.getSeq()%>)">수정</button>
				&nbsp;
				<button type="button" class = "button" 
					onclick="deleteqna(<%=dto.getSeq()%>)">삭제</button>
				&nbsp;
				<%} %>
		</table>
	</div>
	<br>
	<br>


	<br />
	<br />
	<script type="text/javascript">
function answerqna(seq){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/answerqna&seq=<%=dto.getSeq()%>";
}
function updateqna(seq){
	location.href = "<%=request.getContextPath()%>/index.jsp?toss=z_qna/updateqna&seq=<%=dto.getSeq()%>";
}
function deleteqna(seq) {
	location.href = "<%=request.getContextPath() %>/index.jsp?toss=z_qna/deleteqna&seq=<%=dto.getSeq()%>";
}
</script>

</body>
</html>