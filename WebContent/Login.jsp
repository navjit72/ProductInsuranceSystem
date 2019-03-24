<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style type="text/css">
.btn-secondary, .btn-primary{
width: 200px;
}
table input{
margin : 10px;
}
form{
width: 500px;
height : 300px;
border: 1px solid black; 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}

</style>
</head>
<body>

<%
String admin = null;
String user = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("currentAdmin")) admin = cookie.getValue();
	if(cookie.getName().equals("currentUser")) user = cookie.getValue();
}
}
if(admin != null) response.sendRedirect("AdminDashboard.jsp");
if(user != null) response.sendRedirect("UserDashboard.jsp");
%>

<form action="Logindb.jsp" method="post">
<h1>Login Form</h1>
<input type="hidden" name="submitted" value="true">

<table class="table-borderless" style="margin : 0px auto">
<tr>
<th>User name : </th>
<td><input type="text" class="form-control" name="username"/></td>
</tr>
<tr>
<th>Password : </th>
<td><input type="password" class="form-control" name="password"/></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="Login" class="btn btn-secondary" name="login"/></td>
</tr>
<tr>
<td colspan="2"><a href="Register.jsp" class="btn btn-primary" role="button"> New User? Register.</a></td>
</tr>
</table>

<div style="margin-top : 40px;">
<c:if test="${not empty param.errMsg}">
            <div class="alert alert-danger" role="alert"><c:out value="${param.errMsg}" /></div>
        </c:if>
<c:if test="${not empty param.susMsg}">
           <div class="alert alert-success" role="alert"><c:out value="${param.susMsg}" /></div>
        </c:if>
</div>
</form>
</body>
</html>