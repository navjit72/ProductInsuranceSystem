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
<form action="RegisterProductdb.jsp" method="post" style="width: 400px; border: 1px solid black; padding: 10px;">

<input type="hidden" name="submitted" value="true">

<p>User name : <input type="text" name="username" value="${param.username }"/></p>
<p>Product Name : <select name="pname">
<option value="phone">Phone</option>
<option value="note">Note</option>
<option value="camera">Camera</option>
<option value="tv">TV</option>
<option value="oven">Oven</option>
<option value="modem">Modem</option>
</select>
<p>Serial Number: <input type="text" name="serialNo"/></p>
<p>Purchase Date : <input type="date" name="pDate"/><p>


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