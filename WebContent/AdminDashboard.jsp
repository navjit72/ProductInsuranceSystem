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
<title>Admin Dashboard</title>
<link rel="stylesheet" href="file1.css">
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>

form{ 
padding: 10px; 
text-align: center; 
margin: 80px auto;
}

</style>
</head>
<body>
<ul>
  <li><a href="AdminDashboard.jsp">Home</a></li>
  <li><a href="UpdateProducts.jsp">Products</a></li>
  <li><a href="RegisteredProducts.jsp">Registered Products</a></li>
  <li><a href="SearchUsers.jsp">Users</a></li>
  <li><a href="Login.jsp">Logout</a></li>
</ul>

 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
<form action="" method="post">
<h1 style ="text-align: center">Dashboard</h1>
<input type="hidden" name="submitted" value="true">
<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from claims;
   </sql:query>

<table class="table-bordered table-striped" style="margin : 0px auto;">
<tr><th>UserName</th><th>Product Name</th><th>Serial Number</th><th>Purchased Date</th><th>Claimed Date</th><th>Issue</th><th>Status</th><th>Click to Update</th>
</tr>

<c:forEach var="row" items="${usersDetails.rows }">
<sql:query dataSource="${dbsource}" var="productIds">
       SELECT pname from product where pId='${row.pId}';
   </sql:query>
<c:forEach var="rowx" items="${productIds.rows }">
<tr>
<td>${row.username }</td><td>${rowx.pname }</td><td>${row.serialNo}</td><td>${row.pDate }</td><td>${row.claimDate }</td><td>${row.issue }</td><td>${row.status }</td>
<td><input type="radio" name="radiogroup" value="${row.username },${row.pId},${row.serialNo },${row.pDate },${row.claimDate },${row.status },${row.claimId}"/></td>
</tr>
</c:forEach>
</c:forEach>

</table>
<input type="submit" value="Display Info" class= "btn btn-info" name="display"/>
</form>


<form action="UpdateStatusdb.jsp" method="post">
<input type="hidden" name="submitted2" value="true" />

<c:choose>
<c:when test="${param.submitted and empty param.radiogroup}">
<font color="red"><c:out value="No Product selected!" /></font>
</c:when>
<c:when test="${param.submitted and not empty param.radiogroup}">
<c:set var="data" value="${fn:split(param.radiogroup,',') }" />
<table class="table-bordered table-striped" style="margin : 10px auto;">
<tr><th>Serial Number</th><th>Claim Date</th><th>Status</th>
</tr>
<tr>
<td><input type="text" value="${data[2]}" disabled="disabled" class="form-control"/></td>
<td><input type="text" value="${data[4]}" disabled="disabled" class="form-control"/></td>
<td><input type="hidden" value="${data[6]}" name="id"/><select name="status" class="form-control">
<option>Processing</option>
<option>Accepted</option>
<option>Rejected</option>
</select></td>
</tr>
</table>
<input type="submit" value="Update Claim Info" class= "btn btn-info" name="update"/>
</c:when>
</c:choose>

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