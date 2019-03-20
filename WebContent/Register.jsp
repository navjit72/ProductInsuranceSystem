<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register User</title>
<style type="text/css">
.register{
text-align: center;
border-radius: 5px;
font-weight: bold;
margin : 10px;
padding-top : 5px;
width : 100px;
height : 25px;
}
form{
width: 400px;
border: 1px solid black; 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}
table input{
width : 200px;
}
</style>
</head>
<body>

<form action="RegisterUserdb.jsp" method="post">
<h1 style ="text-align: center">Register Form</h1>
<input type="hidden" name="submitted" value="true">
<table style="margin : 0px auto">
<tr>
<th>User name : </th>
<td><input type="text" name="username"/></td>
</tr>
<tr>
<th>Password : </th>
<td><input type="password" name="password"/></td>
</tr>
<tr>
<th>Phone Number : </th>
<td><input type="text" name="phone"/></td>
</tr>
<tr>
<th>Email : </th>
<td><input type="text" name="email"/></td>
</tr>
<tr>
<th>Full Name : </th>
<td><input type="text" name="name"/></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="Register" class= "register" name="register"/></td>
</tr>
</table>

<font color="red"><c:if test="${not empty param.errMsg}">
            <c:out value="${param.errMsg}" />
        </c:if></font>
        <font color="green"><c:if test="${not empty param.susMsg}">
            <c:out value="${param.susMsg}" />
        </c:if></font>
</form>
<a href="Login.jsp">Go To Main Page</a>

</body>
</html>