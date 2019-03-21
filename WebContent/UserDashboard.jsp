<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Dashboard</title>
<style>
.display{
text-align: center;
border-radius: 5px;
font-weight: bold;
margin : 10px;
padding-top : 5px;
width : 150px;
height : 25px;
}
form{ 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}
table input, table select {
width : 200px;
}
table th, table td{
border: 1px solid black;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #dddddd;
}
li {
  float: left;
  border-right: 1px solid black;
}
li:last-child {
  border-right: none;
}
li a {
  display: block;
  padding: 8px;
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

<form action="" method="post">
<h1 style ="text-align: center">Dashboard</h1>
<input type="hidden" name="submitted" value="true">
 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
                           
<sql:query dataSource="${dbsource}" var="regProducts">
       SELECT * from registeredproducts where username='${sessionScope.username}';
   </sql:query>

<table style="margin : 0px auto;border: 1px solid black;">
<tr><th>Product Name</th><th>Serial Number</th><th>Purchase Date</th><th>More info</th>
</tr>

<c:forEach var="row" items="${regProducts.rows }">
<sql:query dataSource="${dbsource}" var="productIds">
       SELECT pname from product where pId='${row.pId}';
   </sql:query>
<c:forEach var="rowx" items="${productIds.rows }">
<tr>
<td>${rowx.pname }</td><td>${row.serialNo}</td><td>${row.purchaseDate }</td>
<td><input type="radio" name="radiogroup" value="${row.pId},${row.serialNo },${row.purchaseDate }"/></td>
</tr>
</c:forEach>
</c:forEach>
<tr>
<td colspan="5"><input type="submit" value="Display Product Info" class= "display" name="display"/></td>
</tr>
</table>

<font color="red"><c:if test="${not empty param.errMsg}">
            <c:out value="${param.errMsg}" />
        </c:if></font>
        <font color="green"><c:if test="${not empty param.susMsg}">
            <c:out value="${param.susMsg}" />
        </c:if></font>

<c:choose>
<c:when test="${param.submitted and empty param.radiogroup}">
<font color="red"><c:out value="No Product selected!" /></font>
</c:when>
<c:when test="${param.submitted and not empty param.radiogroup}">
<c:set var="data" value="${fn:split(param.radiogroup,',') }" />
<sql:query dataSource="${dbsource}" var="claimDetails">
       SELECT * from claims where username='${sessionScope.username}' and pId='${data[0]}' and serialNo='${data[1]}' and pDate='${data[2]}' ;
</sql:query>
<c:choose>
<c:when test="${claimDetails.rowCount==0 }">
<font color="red"><c:out value="No Claim records found!" /></font>
</c:when>
<c:otherwise>
<table style="margin : 50px auto;border: 1px solid black;">
<tr><th>Claim Date</th><th>Issue</th><th>Status</th>
</tr>
<c:forEach var="rowy" items="${claimDetails.rows }">
<tr>
<td>${rowy.claimDate }</td><td>${rowy.issue }</td><td>${rowy.status }</td>
</tr>
</c:forEach>
</table>
</c:otherwise>
</c:choose>
</c:when>
</c:choose>
</form>
</body>
</html>