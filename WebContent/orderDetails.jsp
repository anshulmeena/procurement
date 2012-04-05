<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>
<jsp:include page="header.jsp">
	<jsp:param value="Search Order" name="pageTitle"/>
	<jsp:param value="viewOrder" name="selectedTopMenu"/>
	<jsp:param value="home" name="selectedLeftNav"/>
</jsp:include>
<%
	String tableHtml;
	String query = null;
	String order_id = request.getParameter("ID");
	String vendor = "";
	String order_name = "";
	String order_desc = "";
	String requester = "";
	String req_email = "";
	String department = "";
	String shipTo = "";
	String quantity = "";
	String order_cost = "";
	String shipping_cost = "";
	String order_total = "";
	String date_required = "";
	String date_ordered = "";
	String orderStatus = "";
	String approver = "";
	String date_approved = "";
	String status = "";
	String statusMessage = "";
	

	query = "select O.order_id, O.order_name, O.order_desc, O.vendor, O.requester, O.req_email, O.department, O.shipTo, O.quantity, O.order_cost, O.shippingCost, O.order_total, O.date_ordered, O.date_required, O.date_approved, O.approver, S.status, S.message from `order` O, orderStatus S" 
			+" where (O.order_id ="+order_id+") And (O.orderStatus = S.status_id)" ;
	
	System.out.println(query);
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	
	ResultSet result = connect.generalQuery(query);
	
	int colnumCount = 1;
	while (result.next()){
		vendor = result.getString("vendor");
		order_name= result.getString("order_name");
		order_desc = result.getString("order_desc");
		requester = result.getString("requester");
		req_email = result.getString("req_email");
		department = result.getString("department");
		shipTo = result.getString("shipTo");
		quantity = result.getString("quantity");
		order_cost = result.getString("order_cost");
		shipping_cost = result.getString("shippingCost");
		order_total = result.getString("order_total");
		date_ordered = result.getString("date_ordered");
		date_required = result.getString("date_required");
		date_approved = result.getString("date_approved");
		approver = result.getString("approver");
		status = result.getString("Status");
		statusMessage = result.getString("message");
		
	}
%>
<tr>
	<td>
		<div class="pageContent" id="pageContent">
			<table class="orderDetail_table">
				<tr>
					<td>ID: </td>
					<td><%=order_id %></td>
				</tr>
				<tr>
					<td>Vendor: </td>
					<td><%=vendor%></td>
				</tr>
				<tr>
					<td>Item Name: </td>
					<td><%=order_name%></td>
				</tr>
				<tr>
					<td>Item Description: </td>
					<td><%=order_desc%></td>
				</tr>
				<tr>
					<td>Shipping Cost: </td>
					<td><%=shipping_cost%></td>
				</tr>
				<tr>
					<td>Total Price: </td>
					<td><%=order_total%></td>
				</tr>
				<tr>
					<td>Date Required: </td>
					<td><%=date_required%></td>
				</tr>
				<tr>
					<td>Department: </td>
					<td><%=department%></td>
				</tr>
				<tr>
					<td>Date Ordered: </td>
					<td><%=date_ordered%></td>
				</tr>
				<tr>
					<td>Status: </td>
					<td><%=status%></td>
				</tr>
								<tr>
					<td>Message: </td>
					<td><%=statusMessage%></td>
				</tr>
				<tr>
					<td>Approver: </td>
					<td><%=approver%></td>
				</tr>
				<tr>
					<td>Date Approved: </td>
					<td><%=date_approved%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
</table>
<%
	connect.closeDB();
%>
<jsp:include page="footer.jsp"></jsp:include>