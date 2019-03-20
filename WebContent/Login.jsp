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
<style type="text/css">
.registerButton{
display: block;
width: 200px;
height: 25px;
background-color:black;
color:white;
text-decoration:none;
border-radius: 5px;
font-weight: bold;
margin : 10px;
padding-top : 5px;
}
.login{
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

</style>
</head>
<body>


<form action="Logindb.jsp" method="post">
<h1>Login Form</h1>
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
<td colspan="2"><input type="submit" value="Login" class="login" name="login"/></td>
</tr>
<tr>
<td colspan="2"><a href="Register.jsp" class="registerButton"> New User? Register.</a></td>
</tr>
</table>
<font color="red"><c:if test="${not empty param.errMsg}">
            <c:out value="${param.errMsg}" />
        </c:if></font>
        <font color="green"><c:if test="${not empty param.susMsg}">
            <c:redirect url="RegisterProduct.jsp" >              
        </c:redirect>
        </c:if></font>

</form>

</body>
</html>