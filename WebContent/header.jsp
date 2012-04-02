<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<%@ page import="por.html.controls.*" %>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<%
HttpSession jSession = request.getSession(false);
String topBarUrl = "menu/topBar.jsp";
String topMenu = "menu/menu.jsp";
String leftNav = "menu/leftMenu.jsp";
String selectedLeftNav = request.getParameter("selectedLeftNav");
String selectedTopMenu = request.getParameter("selectedTopMenu");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="js/lib/prototype.js"></script>
	<script type="text/javascript" src="js/src/scriptaculous.js?load=effects,controls"></script>
	<script type="text/javascript" src="js/src/validation.js"></script>
	<script type="text/javascript" src="js/src/calendarview.js"></script>
	<script type="text/javascript" src="js/function.js"></script>
	
	<link href="css/hclsrms.css" rel="stylesheet"></link>
	<link href="css/calendarview.css" rel="stylesheet"></link>
	<title><%=request.getParameter("pageTitle") %></title>
</head>
<body>
<div class="header_div">
	<jsp:include page="<%=topBarUrl %>"></jsp:include>
</div>
<br />
<div>
	<fieldset class="greenfieldset">
		<table width="100%">
			<tr>
				<td rowspan="3" style="vertical-align: top;">
					<jsp:include page="<%=leftNav %>">
						<jsp:param value="<%= selectedLeftNav%>" name="selectedLeftNav"/>
					</jsp:include>
				</td>
			</tr>
			<tr>
				<td>
					<div class="top_nev_div">
					<center>
						<jsp:include page="<%=topMenu %>">
							<jsp:param value="<%=selectedTopMenu %>" name="selectedTopMenu"/>
						</jsp:include>
					</center>
					</div>
				</td>
			</tr>