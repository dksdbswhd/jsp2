<%@page import="dao.CommentDao"%>
<%@page import="dto.Comment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("UTF-8");
	int mref;
	CommentDao dao = CommentDao.getInstance();
	if(request.getParameter("del") != null){	//삭제
		int cmtidx = Integer.parseInt(request.getParameter("cmtidx"));
		int idx = Integer.parseInt(request.getParameter("idx"));
		dao.delete(cmtidx);
		mref=idx;
	} else {	//댓글 추가
	mref = Integer.parseInt(request.getParameter("mref"));
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	String ip = request.getRemoteAddr();
	
	Comment dto = new Comment(0,mref,name,password,content,null,ip);
	dao.insert(dto);
//	dao.updateCommentCnt(mref);	//mref 값이 글상세보기의 idx였습니다.
	}
	dao.updateCountAll(mref);
	response.sendRedirect("detailAction.jsp?page=1&idx=" + mref);
%>