<%@page import="dao.FreeboardDao"%>
<%@page import="dto.Freeboard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String subject = request.getParameter("subject");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	String ip = request.getRemoteAddr();
	Freeboard dto = new Freeboard();
	dto.setIp(ip);
	dto.setName(name);
	dto.setPassword(password);
	dto.setSubject(subject);
	dto.setContent(content);
//	out.print(dto);   //테스트용.
	FreeboardDao dao = FreeboardDao.getInstance();
	dao.insert(dto);
	response.sendRedirect("listAction.jsp");
%>