<% 
	HttpSession jSession = request.getSession(false);
	jSession.invalidate();

	response.sendRedirect("loginBean.jsp");
%>