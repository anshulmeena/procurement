<%@ page import="java.sql.ResultSet"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:include page="header.jsp">
	<jsp:param value="New Order" name="pageTitle"/>
	<jsp:param value="newOrder" name="selectedTopMenu"/>
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

	DbConnect connect = new DbConnect();
	connect.connectDB("purchasing");
	String query = "select accountName, email from accountInfo";
	ResultSet result = connect.generalQuery(query);
%>
<tr>
	<center>
		<span id="message"><%=message%></span>
	</center>
<td>
<div class="pageContent" id="pageContent">

<form action="submitNewOrder.jsp" id="neworder" name="newOrderForm">
<input type="hidden" value="newPORequest" name="commingFrom"/>
			<table>
				<tr>
					<td>Item</td>
					<td>
						<input type="text" name="item_name" id="item_name" class="required" title="Please include Item no."/>
						<input type="button" name="oldItem" id="oldItem" value="Search Old" 
						onclick="window.location='searchOld.jsp';"/>
					</td>
				</tr>
				<tr>
					<td>Color</td>
					<td><input type="text" name="color" id="color" class="DummyRequired"/></td>
				</tr>
				<tr>
					<td>Quantity</td>
					<td><input type="text" name="quantity" id="quantity" class="required validate-digits"/></td>
				</tr>
				<tr>
					<td>Unit Price</td>
					<td>
						<input type="text" name="price" id="price" class="required validate-currency-dollar"/>
						<span id="total_price"></span>
					</td>
				</tr>
				<tr>
					<td>Vendor Name</td>
					<td><input type="text" name="vendor" id="vendor" class="required"/></td>
				</tr>
				<tr>
					<td>Description</td>
					<td>
						<textarea cols="50" id="description" name="description" rows="7" class="required"></textarea>
						<div id="advice-required-message" class="validation-advice" style="display: none;">Please include the Desctiption</div>
					</td>
				</tr>
				<tr>
					<td>Date Required</td>
					<td>
					    <input type="text" name="date_required" id="date_required" class="required validate-date"/>
					    <input type="button" name="datepick" id="datepick" value="Show Date"/>
					    <span id="dateRequiredNote"></span>
					</td>
				</tr>
				<tr>
					<td>URL</td>
					<td>
					    <input type="text" name="url" id="url" class="required validate-url"/>
					</td>
				</tr>
				<tr>
					<td>Account</td>
					<td>
					    <select name="account" id="account" class="required validate-selection">
					    <option value="">Select Account</option>
					    <% while (result.next()){ %>
					    <option value="<%=result.getString("email") %>"><%=result.getString("accountName") %></option>
   						<% } 
    					connect.closeDB();
   						%>
					    </select>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Save" name="save" /> 
					<input type="submit" value="Save and Add more" name="savenadd" /> 
					<input type="button" value="reset" name="reset" onclick="validate.reset(); $('neworder').reset; $('item_name').focus();"></input></td>
				</tr>
			</table>
			</form>
</div>
<script type="text/javascript">
<!--
	window.onload = function() {
		Calendar.setup({
			dateField : 'date_required',
			triggerElement : 'datepick'
		});
	};
	var validate = new Validation('neworder', {
		useTitles : true,
		immediate : true,
		onSbumit : false
		});
	$('item_name').focus(); 
	Event.observe($('price'), 'change', function(){$('total_price').update("Total Price: "+$F('quantity')*$F('price'));});
	Event.observe($('quantity'), 'change', function(){$('total_price').update("Total Price: "+$F('quantity')*$F('price'));});
	Event.observe($('datepick'), 'click', function(){$('dateRequiredNote').update("Give at least 2 weeks to process.");});
//-->
</script>
</td>
</tr>
</table>
<jsp:include page="footer.jsp"></jsp:include>