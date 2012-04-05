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
<tr>
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
			+" AND (emp_email =\""+userData.getEmail1()+"\")"
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
	tableHtml += "<th><a href='viewSavedOrder.jsp?sort=accountNum'>Account Num</a></th>";
	tableHtml += "<th><a href='viewSavedOrder.jsp?sort=emp_email'>Order By</a></th>";
	tableHtml += "<th>Details</th>";
	tableHtml += "<th>Place Order</th>";
	tableHtml += "<th>Delete</th>";
	
	while (result.next()) {
		String id = "tr" + colnumCount;
		tableHtml += "<tr id=" + id + ">";
		tableHtml += "<td>" + result.getString("vendor") + "</td>";
		tableHtml += "<td>" + result.getString("itemName") + "</td>";
		tableHtml += "<td>" + result.getString("quantity") + "</td>";
		tableHtml += "<td>" + result.getString("total_price") + "</td>";
		tableHtml += "<td>" + result.getString("date_required") + "</td>";
		tableHtml += "<td>" + result.getString("accountNum") + "</td>";
		tableHtml += "<td>" + result.getString("emp_email") + "</td>";
		tableHtml += "<td><a href='itemTableDetails.jsp?ID="+result.getString("ID")+"'>Details</a></td>";
		tableHtml += "<td><a href='placeOrder.jsp?ID="+result.getString("ID")+"&action=placeOrder'>Place Order</a></td>";
		tableHtml += "<td><a href='placeOrder.jsp?ID="+result.getString("ID")+"&action=delete'>Delete</a></td>";
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