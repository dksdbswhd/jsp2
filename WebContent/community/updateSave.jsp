<%@page import="dao.FreeboardDao"%>
<%@page import="dto.Freeboard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//수정 버튼-> 내용 변경 -> 저장버튼 으로 실행됩니다.
	request.setCharacterEncoding("UTF-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String subject = request.getParameter("subject");
//	String password = request.getParameter("password");
	String content = request.getParameter("content");
//	String ip = request.getRemoteAddr();
	Freeboard dto = new Freeboard();
//	dto.setIp(ip);
//	dto.setPassword(password);
	dto.setIdx(idx);
	dto.setSubject(subject);
	dto.setContent(content);
	FreeboardDao dao = FreeboardDao.getInstance();
	dao.update(dto);
	//response.sendRedirect("updateAction.jsp?update=&idx="+idx);
	response.sendRedirect("detailAction.jsp?update=&idx="+idx + "&page=1");
%>