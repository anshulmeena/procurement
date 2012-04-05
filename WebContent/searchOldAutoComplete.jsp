<%@ page import="java.sql.ResultSet"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="java.sql.ResultSet"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>

<%
HttpSession jSession = request.getSession(false);

DbConnect connect = new DbConnect();
//connect.closeDB();
connect.connectDB("props");
//Need's to be changed on production server
String action = request.getParameter("Action");
String item_name = request.getParameter("searchItemName");
String vendor = request.getParameter("searchVendor");
String desription = request.getParameter("searchDescription");
String date_required = request.getParameter("date_required");
String account = request.getParameter("account");

String list;
list = "<ul>";
if(action.equals("item")){
	String query = "select Distinct subjects from props where subjects like '%"+item_name+"%' order by subjects";
	ResultSet result = connect.generalQuery(query);
	while(result.next()){
			list += "<li>"+result.getString("subjects")+"</li>";
	}
}else if(action.equals("description")){
	String query = "select Distinct subjects from props where subjects like '%"+desription+"%' order by subjects";
	ResultSet result = connect.generalQuery(query);
	while(result.next()){
			list += "<li>"+result.getString("subjects")+"</li>";
	}
} else if(action.equals("vendor")){
	String query = "select Distinct subjects from props where subjects like '%"+vendor+"%' order by subjects";
	ResultSet result = connect.generalQuery(query);
	while(result.next()){
			list += "<li>"+result.getString("subjects")+"</li>";
	}
}else {
	list += "<li></li>";
}

list += "</ul>";
%>

<%=list %>

<%
connect.closeDB();
%>