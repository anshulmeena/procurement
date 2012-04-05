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
	int updateOrderStatus = userData.getUpdateOrderStatus();
	
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	
	String query = "Select * from itemTable where ID = "+order_id;
	String vendor = "";
	String item_desc = "";
	String itemName = "";
	String requester = "";
	String req_email = "";
	String department = "";
	String shipTo = "";
	String quantity = "";
	String unit_price = "";
	String shippingCostString = "";
	float shippingCost = 0;
	String total_price = "";
	String order_total = "";
	String reason = "";
	String color = "";
	String date_required = "";

	String account_email = "";
	String account_num = "";
	String url = "";
	String notes = "";
	String date_ordered = "";
	String date_approved = "";
	String date_received = "2012-01-01";
	
	ResultSet result = connect.generalQuery(query);
	while(result.next()){
		vendor = result.getString("vendor");
		itemName= result.getString("itemName");
		item_desc = result.getString("item_desc");
		quantity= result.getString("quantity");
		requester = result.getString("requester");
		req_email = result.getString("emp_email");
		department = result.getString("department");
		shipTo = result.getString("shipTo");
		shippingCostString = result.getString("shippingCost");
		shippingCost = Float.valueOf(shippingCostString).floatValue();
		account_email = result.getString("account_email");
		account_num = result.getString("accountNum");
		total_price = result.getString("total_price");
		date_ordered = result.getString("date_ordered");
		date_required = result.getString("date_required");
	}

	if(action.equals("placeOrder")){
		String approveQuery = "INSERT INTO `order` (`order_name`, `order_desc`,`vendor`, `requester`, `req_email`, `department`, `shipTo`, `quantity`, `order_cost`, `shippingCost`, `order_total`, `date_ordered`, `date_required`, `date_approved`, `approver`, `account_email`, `accountNum`, `po_number`, `date_received`, `orderStatus`)"
				+" VALUES ('"+itemName+"', '"+item_desc+"', '"+vendor+"', '"+requester+"', '"+req_email+"', '"+department+"', '"+shipTo+"', '"+quantity+"', '"+total_price+"', '"+shippingCost+"', '"+total_price+"', '"+date_ordered+"', '"+date_required+"', '2012-01-01', '"+account_email+"', '"+account_email+"', '"+account_num+"', '', '"+date_received+"', '"+updateOrderStatus+"')";
		connect.generalUpdateQuery(approveQuery);
		approveQuery = "Delete from `itemTable` where ID ="+order_id;
		connect.generalUpdateQuery(approveQuery);
		response.sendRedirect("listAllBasic.jsp?Status=Success&Message=Item \""+itemName+"\" is ordered !");
	}else if(action.equals("delete")){
		String disApproveQuery = "Delete from `itemTable` where ID ="+order_id;
		connect.generalUpdateQuery(disApproveQuery);
		response.sendRedirect("listAllBasic.jsp?Status=Failur&Message=Item \""+itemName+"\" is Deleted !S");
	}
	connect.closeDB();
%>