<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Product</title>
<link rel="stylesheet" href="file1.css">
<style>
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
width: 500px;
border: 1px solid black; 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}
</style>
</head>
<body>
<ul>
  <li><a href="UserDashboard.jsp">Home</a></li>
  <li><a href="RegisterProduct.jsp">Register Product</a></li>
  <li><a href="ClaimProduct.jsp">Claim Product</a></li>
  <li><a href="Login.jsp">Logout</a></li>
</ul>

<form action="RegisterProductdb.jsp" method="post">
<h1 style ="text-align: center">Register Product Form</h1>
<input type="hidden" name="submitted" value="true">
<table style="margin : 0px auto">
<tr>
<th>User name : </th>
<td><c:out value="${sessionScope.username}" /></td>
</tr>
<tr>
<th>Product Name :  </th>
<td><select name="pname">
 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
 
 
        <sql:query dataSource="${dbsource}" var="result">
            SELECT * from product;
        </sql:query>
<c:forEach var="row" items="${result.rows}">
<option><c:out value="${row.pname}"/></option>
</c:forEach>
</select></td>
</tr>
<tr>
<th>Serial Number : </th>
<td><input type="text" name="serialNo"/></td>
</tr>
<tr>
<th>Purchase Date : </th>
<c:set var="now" value="<%= new java.util.Date() %>" />
<fmt:formatDate type="date" pattern="yyyy-MM-dd" value="${ now }" var="maxDate" />
<td><input type="date" name="pDate" max="${ maxDate }"></td>
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

</body>
</html>