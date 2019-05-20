<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("utf-8");
    response.setCharacterEncoding("uft-8");
    NoticeDAO noticeDAO = new NoticeDAO();
    //first.curPage->리턴받아오자. startRow lastRow
    int curPage =1;
    try{
    	curPage = Integer.parseInt(request.getParameter("curPage"));
    	if(curPage<1){
    		curPage = 1;
    	};
    }catch(Exception e){
    	
    }
    String kind = request.getParameter("kind");
    if(kind == null){
    	kind="title";
    }else if(kind.equals("c")){
    	kind="contents";
    }else if(kind.equals("w")){
    	kind="writer";
    }else{
    	kind="title";
    }
    String search = request.getParameter("search");
    if(search==null){
    	search="";
    }
    //1.한 페이지에 출력할 개수
    int perPage = 10;
    int startRow = (curPage-1)*perPage+1;
    int lastRow = curPage*perPage;
    ArrayList<NoticeDTO> ar=noticeDAO.noticeSelectList(startRow, lastRow, kind, search);
    //2.총 글의 개수 102개임
    int totalCount = noticeDAO.totalCount();
    //3.총 페이지 개수 11개
    int totalPage = (totalCount/perPage);
    if(totalCount%perPage!=0){
    	totalPage++;
    }
    //4.블럭당 숫자의 범위
    int perBlock = 10;
    //5.총 블럭 수
    int totalBlock = (totalPage/perBlock);
    if(totalPage%perBlock!=0){
    	totalBlock++;
    };
    //6.현재 블럭의 번호 찾기
    int curBlock = curPage/perBlock;
    if(curPage%perBlock!=0){
    	curBlock++;
    };
    //7.curBlock를 이용해 startNum과 lastNum 찾기
    int startNum=(curBlock-1)*perBlock+1;
    int lastNum=curBlock*perBlock;
    if(curBlock==totalBlock){
    	lastNum=totalPage;
    }
    %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<jsp:include page="../temp/css_meta.jsp"></jsp:include>
<style type="text/css">
	.main{
		margin-top:100px;
	}
</style>
</head>
<body>
<jsp:include page="../temp/header_nav.jsp"></jsp:include>
<div class="container" >
	<div class="row">
		<table class="main table table-hover">
			<tr>
				<td>NUM</td><td>TITLE</td><td>WRITER</td><td>DATE</td><td>HIT</td>
			</tr>
			<%for(NoticeDTO dto : ar){ %>
				<tr>
				<td><%=dto.getNum() %></td>
				<td><%=dto.getTitle() %></td>
				<td><%=dto.getWriter() %></td>
				<td><%=dto.getReg_date() %></td>
				<td><%=dto.getHit() %></td>
				</tr>
			<%} %>
		</table>
	</div>	
	<div class="row">
		<select name="kind">
			<option value="t">Title</option>		
			<option value="w">Writer</option>	
			<option value="c">Contents</option>	
		</select>
		<input type="text" name="search">
	</div>
	<div class="row">
		<%if(curBlock>1){ %>
		<a href="./noticeList.jsp?curPage=<%=startNum-1%>&">[이전]</a>
		<%} %>
		<%for(int i =startNum; i<=lastNum;i++) {%>
		<a href="./noticeList.jsp?curPage=<%=i %>"><%=i %></a>
		<%} %>
		<%if(curBlock<totalBlock){ %>
		<a href="./noticeList.jsp?curPage=<%=lastNum+1%>">[다음]</a>
		<%} %>
	</div>
</div>
<jsp:include page="../temp/footer.jsp"></jsp:include>
</body>
</html>