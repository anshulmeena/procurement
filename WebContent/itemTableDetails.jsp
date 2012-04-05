<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>
<jsp:include page="header.jsp">
	<jsp:param value="Search Order" name="pageTitle"/>
	<jsp:param value="savedOrder" name="selectedTopMenu"/>
	<jsp:param value="home" name="selectedLeftNav"/>
</jsp:include>
<%
	String tableHtml;
	String query = null;
	String email = userData.getEmail1();
	String ID = request.getParameter("ID");
	String vendor = "";
	String itemName = "";
	String item_desc = "";
	String reason = "";
	String color = "";
	String quantity = "";
	String unit_price = "";
	String total_price = "";
	String date_required = "";
	String account_contact = "";
	String url = "";
	String notes = "";
	String date_ordered = "";
	String date_approved = "";
	String emp_email = "";
	

	query = "select * from `itemTable` where ID ="+ID;
	
	System.out.println(query);
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	
	ResultSet result = connect.generalQuery(query);
	int colnumCount = 1;
	while (result.next()){
		vendor = result.getString("vendor");
		itemName= result.getString("itemName");
		item_desc = result.getString("item_desc");
		reason = result.getString("reason");
		color = result.getString("color");
		quantity = result.getString("quantity");
		unit_price = result.getString("unit_price");
		total_price = result.getString("total_price");
		date_required = result.getString("date_required");
		account_contact = result.getString("account_email");
		url = result.getString("url");
		notes = result.getString("notes");
		
	}
%>
<%//=tableHtml%>
<tr>
	<td>
		<div class="pageContent" id="pageContent">
			<table class="orderDetail_table">
				<tr>
					<td>ID: </td>
					<td><%=ID %></td>
				</tr>
				<tr>
					<td>Vendor: </td>
					<td><%=vendor%></td>
				</tr>
				<tr>
					<td>Item Name: </td>
					<td><%=itemName%></td>
				</tr>
				<tr>
					<td>Item Description: </td>
					<td><%=item_desc%></td>
				</tr>
				<tr>
					<td>Reason: </td>
					<td><%=reason%></td>
				</tr>
				<tr>
					<td>Color: </td>
					<td><%=color%></td>
				</tr>
				<tr>
					<td>Unit Price: </td>
					<td><%=unit_price%></td>
				</tr>
				<tr>
					<td>Total Price: </td>
					<td><%=total_price%></td>
				</tr>
				<tr>
					<td>Date Required: </td>
					<td><%=date_required%></td>
				</tr>
				<tr>
					<td>Account Email: </td>
					<td><%=account_contact%></td>
				</tr>
				<tr>
					<td>Notes: </td>
					<td><%=notes%></td>
				</tr>
				<tr>
					<td>URL: </td>
					<td><%=url%></td>
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