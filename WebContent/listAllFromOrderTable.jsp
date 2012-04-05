<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>
<jsp:include page="header.jsp">
	<jsp:param value="Search Order" name="pageTitle"/>
	<jsp:param value="listAllOrder" name="selectedTopMenu"/>
	<jsp:param value="home" name="selectedLeftNav"/>
</jsp:include>
<tr>
	<td>
		<div class="pageContent" id="pageContent">
<%
	String tableHtml;
	String query = null;
	String sort = request.getParameter("sort");

	query = "select * from `order` where"
			+"(req_email =\""+userData.getEmail1()+"\")"
			+" OR (approver = \""+userData.getEmail1()+"\")"
			+" OR (orderStatus IN (2,3,4))"
			+" order by "
			+ sort + " asc";
	
	System.out.println(query);
	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	
	ResultSet result = connect.generalQuery(query);
	ResultSetMetaData metadata = result.getMetaData();
	int colnumCount = 1;
	tableHtml = "<table class=\"data_table\"><tbody><tr>";

	tableHtml += "<th><a href='listAllBasic.jsp?sort=vendor'>Vendor</a></th>";
	tableHtml += "<th><a href='listAllBasic.jsp?sort=order_name'>Item Name</a></th>";
	tableHtml += "<th>Quantity</th>";
	tableHtml += "<th>Total Price</th>";
	tableHtml += "<th>Date Requested</th>";
	tableHtml += "<th>Sent to</th>";
	tableHtml += "<th>Details</th>";
	
	while (result.next()) {
		String id = "tr" + colnumCount;
		tableHtml += "<tr id=" + id + ">";
		tableHtml += "<td>" + result.getString("vendor") + "</td>";
		tableHtml += "<td>" + result.getString("order_name") + "</td>";
		tableHtml += "<td>" + result.getString("quantity") + "</td>";
		tableHtml += "<td>" + result.getString("order_total") + "</td>";
		tableHtml += "<td>" + result.getString("date_required") + "</td>";
		tableHtml += "<td>" + result.getString("approver") + "</td>";
		tableHtml += "<td><a href='orderDetails.jsp?ID="+result.getString("order_id")+"'>Details</a></td>";
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