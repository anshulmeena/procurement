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
				<form method="get" id="saved_selection_form">
					<select id="archive_select" onchange="archive_option();">
						<option value="0">Most Recent</option>
						<option value="top30">Top 30</option>
						<option value="top60">Top 60</option>
						<option value="all">Show All</option>
					</select>
				</form>
			<div id="dataTable" class="dataTable"></div>
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