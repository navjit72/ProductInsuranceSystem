<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
<center>
<h1 style ="text-align: center">Register Form</h1>
<form action="RegisterUserdb.jsp" method="post" style="width: 400px; border: 1px solid black; padding: 10px;">

<input type="hidden" name="submitted" value="true">

<p>User name : <input type="text" name="username"/></p>
<p>Password : <input type="password" name="password"/><p>
<p>Phone Number : <input type="text" name="phone"/></p>
<p>Email : <input type="text" name="email"/><p>
<p>Name : <input type="text" name="name"/></p>

<input type="submit" value="Register" name="register"/>
</form>
<font color="red"><c:if test="${not empty param.errMsg}">
            <c:out value="${param.errMsg}" />
        </c:if></font>
        <font color="green"><c:if test="${not empty param.susMsg}">
            <c:out value="${param.susMsg}" />
        </c:if></font>
</center>
<a href="MainPage.jsp">Go To Main Page</a>

</body>
</html>