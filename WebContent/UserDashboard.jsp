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
<link rel="stylesheet" href="file1.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
form{ 
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

<form action="" method="post">
<h1 style ="text-align: center">Dashboard</h1>
<input type="hidden" name="submitted" value="true">
 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
                           
<sql:query dataSource="${dbsource}" var="regProducts">
       SELECT * from registeredproducts where username='${sessionScope.username}';
   </sql:query>

<table class="table-bordered table-striped" style="margin : 0px auto;">
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
</table>
<input type="submit" value="Display Product Info" class= "btn btn-info" name="display"/>

<div style="margin-top : 40px;">
<c:if test="${not empty param.errMsg}">
            <div class="alert alert-danger" role="alert"><c:out value="${param.errMsg}" /></div>
        </c:if>
<c:if test="${not empty param.susMsg}">
           <div class="alert alert-success" role="alert"><c:out value="${param.susMsg}" /></div>
        </c:if>
</div>

<c:choose>
<c:when test="${param.submitted and empty param.radiogroup}">
<div class="alert alert-danger" role="alert"><c:out value="No Product selected!" /></div>
</c:when>
<c:when test="${param.submitted and not empty param.radiogroup}">
<c:set var="data" value="${fn:split(param.radiogroup,',') }" />
<sql:query dataSource="${dbsource}" var="claimDetails">
       SELECT * from claims where username='${sessionScope.username}' and pId='${data[0]}' and serialNo='${data[1]}' and pDate='${data[2]}' ;
</sql:query>
<c:choose>
<c:when test="${claimDetails.rowCount==0 }">
<div class="alert alert-danger" role="alert"><c:out value="No Claim records found!" /></div>
</c:when>
<c:otherwise>
<table class="table-bordered table-striped" style="margin : 50px auto;">
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