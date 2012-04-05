<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>
<jsp:include page="header.jsp">
	<jsp:param value="Search Order" name="pageTitle"/>
	<jsp:param value="approve" name="selectedTopMenu"/>
	<jsp:param value="home" name="selectedLeftNav"/>
</jsp:include>
<%
	String message = "";
	try {
		if (request.getParameter("Status").equals("Failur")) {
			message = request.getParameter("Message");
		} else if (request.getParameter("Status").equals("Success")) {
			message = request.getParameter("Message");
		}
	} catch (Exception e) {
		message.equals("");
	}
%>
<tr>
	<center>
		<span id="message"><%=message%></span>
	</center>
<td>
		<div class="pageContent" id="pageContent">
<%
	String tableHtml;
	String email = userData.getEmail1();
	String sort = request.getParameter("sort");
	String var = request.getParameter("value");
	
	String query = null;

	query = "select * from `itemTable` where"
			+"(order_id = -1)"
			+" AND (account_email =\""+userData.getEmail1()+"\")"
			+" order by "
			+ sort + " asc";
	
	System.out.println(query);
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	
	ResultSet result = connect.generalQuery(query);
	ResultSetMetaData metadata = result.getMetaData();
	int colnumCount = 1;
	tableHtml = "<table class=\"data_table\"><tbody><tr>";

	tableHtml += "<th><a href='viewSavedOrder.jsp?sort=vendor'>Vendor</a></th>";
	tableHtml += "<th><a href='viewSavedOrder.jsp?sort=itemName'>Item Name</a></th>";
	tableHtml += "<th>Quantity</th>";
	tableHtml += "<th>Total Price</th>";
	tableHtml += "<th>Date Requested</th>";
	tableHtml += "<th><a href='viewSavedOrder.jsp?sort=emp_email'>Order By</a></th>";
	tableHtml += "<th>Details</th>";
	tableHtml += "<th>Approve</th>";
	tableHtml += "<th>Disapprove</th>";
	
	while (result.next()) {
		String id = "tr" + colnumCount;
		tableHtml += "<tr id=" + id + ">";
		tableHtml += "<td>" + result.getString("vendor") + "</td>";
		tableHtml += "<td>" + result.getString("itemName") + "</td>";
		tableHtml += "<td>" + result.getString("quantity") + "</td>";
		tableHtml += "<td>" + result.getString("total_price") + "</td>";
		tableHtml += "<td>" + result.getString("date_required") + "</td>";
		tableHtml += "<td>" + result.getString("emp_email") + "</td>";
		tableHtml += "<td><a href='orderDetails.jsp?ID="+result.getString("ID")+"'>Details</a></td>";
		tableHtml += "<td><a href='approveOrder.jsp?ID="+result.getString("ID")+"&action=approve'>Approve</a></td>";
		tableHtml += "<td><a href='approveOrder.jsp?ID="+result.getString("ID")+"&action=disApprove'>Disapprove</a></td>";
		tableHtml += "</tr>";
		colnumCount++;
	}
	tableHtml += "</tbody></table>";
%>

<%=tableHtml%>

<%
	connect.closeDB();
%>
		</div>
	</td>
</tr>
</table>
<div>
</div>
<jsp:include page="footer.jsp"></jsp:include>