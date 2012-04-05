<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>
<%
	String action = request.getParameter("action");
	String order_id = request.getParameter("ID");
	//String updateOrderStatus = request.getParameter("statusUpdate");
	int updateOrderStatus = userData.getUpdateOrderStatus();
	
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");

	if(action.equals("approve")){
		String approveQuery = "Update `order` set `orderStatus` = "+updateOrderStatus+", `date_approved` = NOW(), `approver` = '"+userData.getEmail1()+"' where order_id = "+order_id;
		connect.generalUpdateQuery(approveQuery);
		response.sendRedirect("viewPendingOrder.jsp?Status=Success&Message=Item ID \""+order_id+"\" is Approved.");
	}else if(action.equals("disApprove")){
		String disApproveQuery = "Delete from `order` where order_id = "+order_id;
		connect.generalUpdateQuery(disApproveQuery);
		connect.closeDB();
		response.sendRedirect("viewPendingOrder.jsp?Status=Failur&Message=Item ID \""+order_id+"\" is Disapproved.");
	}
%>