<%@ page import="org.mindgrub.hcl.API" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:useBean id="userData" class="por.beans.User" scope="session"></jsp:useBean>
<jsp:useBean id="accountData" class="por.beans.Account" scope="session"></jsp:useBean>

<%
HttpSession jSession = request.getSession(false);

String redirectUrl = Config.baseUrl;
String item_name = request.getParameter("item_name");
String color = request.getParameter("color");
int quantity = Integer.parseInt(request.getParameter("quantity"));
float price = Float.parseFloat(request.getParameter("price"));
String vendor = request.getParameter("vendor");
String desription = request.getParameter("description");
String date_required = request.getParameter("date_required");
String url = request.getParameter("url");
String account = request.getParameter("account");
String unit_measure = request.getParameter("unit_measure");
float totalPrice = quantity*price;

DbConnect connect = new DbConnect();
System.out.println("accountEmail: "+account);
connect.connectDB("purchasing");
String query = "select * from Accounts A, accountsOwner O where (O.email=\""+account+"\") AND (A.account_id = O.owner_id)";
ResultSet result = connect.generalQuery(query);
while (result.next()){
	accountData.setAccountid(result.getString("account_id"));
	accountData.setAccountNum(result.getString("account"));
	accountData.setAccountName(result.getString("accountName"));
	accountData.setAccountOwner(result.getString("owner_id"));
	accountData.setOwnerName(result.getString("Name"));
	accountData.setOwnerEmail(result.getString("email"));
}
String itemQuery = "INSERT INTO `itemTable` (`emp_email`, `order_id`, `vendor`, `itemName`, `item_desc`, `reason`, `color`, `quantity`, `unit_price`, `unit_measure`, `total_price`, `date_required`, `account_email`, `accountNum` ,`url`, `notes`, `date_ordered`, `date_approved`, `status_id`) VALUES ('"+userData.getEmail1()+"','-1', '"+vendor+"', '"+item_name+"', '"+desription+"', ' ', '"+color+"', '"+quantity+"', '"+price+"', '"+unit_measure+"', '"+totalPrice+"', '"+date_required+"', '"+accountData.getOwnerEmail()+"', '"+accountData.getAccountNum()+"', '"+url+"', 'Pending till move to order table.', NOW(), NULL, '1');";

connect.generalUpdateQuery(itemQuery);

System.out.println("Query: "+itemQuery);
System.out.println("item_name: "+item_name);
System.out.println("Quantity: "+quantity);
System.out.println("Price: "+price);
System.out.println("Total Price: "+totalPrice);
connect.closeDB();
response.sendRedirect(redirectUrl+"newPORequest.jsp?Status=Success&Message=Order Saved. Please check saved orders to complete the process.");
%>
