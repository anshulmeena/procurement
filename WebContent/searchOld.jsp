<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="por.database.*" %>
<%@ page import="por.global.*" %>
<%@ page import="por.internal.admin.UserRights"%>
<jsp:include page="header.jsp">
	<jsp:param value="Search Order" name="pageTitle"/>
	<jsp:param value="viewOrder" name="selectedTopMenu"/>
	<jsp:param value="home" name="selectedLeftNav"/>
</jsp:include>
<%
String commingFrom = request.getParameter("commingFrom");
//if(commingFrom.equals("searchOld")){
%>
<tr>
	<td>
	<div class="pageContent" id="pageContent">
			<p>Search Item</p>
			<br />
			<form id="searchItemForm" action="searchOld.jsp" method="get">
			<input type="hidden" value="searchOld" name="commingFrom"/>
				<table border="0px">
					<tr>
						<td class="field-label">Item Name:</td>
						<td>
							<input type="text" id="searchItemName" name="searchItemName" class="dexagogoinput" />
							<div id="autoItemName_div" class="autocomplete">
							</div>
						</td>
						<td></td>
						<td class="field-label">Discription:</td>
						<td colspan="4">
							<input type="text" id="searchDescription" name="searchDescription" class="dexagogoinputextra" />
							<div id="autoDescription_div" class="autocomplete">
							</div>
						</td>
						<td></td>
					</tr>
					<tr>
						<td class="field-label">Vendor:</td>
						<td>
							<input type="text" id="searchVendor" name="searchVendor" class="dexagogoinput" />
							<div id="autoVendor_div" class="autocomplete" style="">
								<ul></ul>
							</div>
						</td>
						<td></td>
					</tr>
					<tr>
						<td><input type="submit" value="Search" id="submit" /></td>
						<td>
							<input type="button" value="Reset"
							onclick="$('searchItemForm').reset(); $('searchItemName').focus();" />
						</td>
						<td></td>
					</tr>
				</table>
			</form>
		</div>
	</td>
</tr>
</table>
<div>
</div>
<%//} else{ %>
<%//} %>
<script type="text/javascript">
<!--
$('searchItemName').focus();
new Ajax.Autocompleter("searchItemName", "autoItemName_div", "searchOldAutoComplete.jsp?Action=item",{
	minChars: 1
});
new Ajax.Autocompleter("searchDescription", "autoDescription_div", "searchOldAutoComplete.jsp?Action=description",{
	minChars: 1
});
new Ajax.Autocompleter("searchVendor", "autoVendor_div", "searchOldAutoComplete.jsp?Action=vendor",{
	minChars: 1
});
//-->
</script>
<jsp:include page="footer.jsp"></jsp:include>