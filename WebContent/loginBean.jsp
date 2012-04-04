<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Purchasing Login</title>
<script type="text/javascript" src="js/lib/prototype.js"></script>
<script type="text/javascript" src="js/src/scriptaculous.js?load=effects,controls"></script>
<script type="text/javascript" src="js/src/validation.js"></script>

<link href="css/hclsrms.css" rel="stylesheet"></link>
<%
String message = "";
try{
	if(request.getParameter("Status").equals("Failur")){
		message = request.getParameter("Message");
	}
}catch(Exception e){
	message.equals("");
}
%>
</head>
<body>
	<center>
		<div class="pageheading">
			<h1>HCL Procurement Application</h1>
		</div>
	</center>
	<center><span id="message"><%=message %></span></center>

	
	<center>
	<div id="login_div">
		<fieldset class="greenfieldset">
			<form action="loginSubmit.jsp" method="POST" id="login_form">
				<table>
					<tbody>
						<tr>
							<td>User Name</td>
							<td><input type="text" name="username" class="required" id="username" title="This is a required field. eg. abc.def@hclibrary.org"/></td>
						</tr>
						<tr>
							<td>Password</td>
							<td><input type="password" name="password" class="required" /></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td><input type="submit" value="Login"/></td>
							<td><input type="reset" value="Clear" onclick="$('login_form').reset(); $('username').focus(); validate.reset();"/></td>
						</tr>
					</tbody>
				</table>
			</form>	
		</fieldset>
	</div>
</center>
<center>
	<p><font style="font-size: 12px">&copy; 2012 HCL Procurement</font></p>
</center>
</body>
<script type="text/javascript">
  var validate = new Validation('login_form', {
	  useTitles : true,
	  immediate : true}); 
  $('username').focus();  
  Element.hide.delay(20,'message');
</script>
</html>