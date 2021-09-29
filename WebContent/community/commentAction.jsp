<%@page import="dao.CommentDao"%>
<%@page import="dto.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int mref = Integer.parseInt(request.getParameter("mref"));
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	String ip = request.getRemoteAddr();
	
	Comment dto = new Comment(0,mref,name,password,content,null,ip);
	CommentDao dao = CommentDao.getInstance();
	dao.insert(dto);
	dao.updateCommentCnt(mref);	//mref 값이 글상세보기의 idx였습니다.
	
	response.sendRedirect("detailAction.jsp?page=1&idx=" + mref);
%>