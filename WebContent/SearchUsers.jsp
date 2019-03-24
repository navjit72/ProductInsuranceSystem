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
<title>Users</title>
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
.btn-info{
width: 200px;
}
form{ 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}
</style>
</head>
<body>
<ul class="nav nav-tabs justify-content-center">
  <li class="nav-item"><a class="nav-link" href="AdminDashboard.jsp">Home</a></li>
  <li class="nav-item"><a class="nav-link" href="AddProduct.jsp">Add Product</a></li>
  <li class="nav-item"><a class="nav-link" href="UpdateProducts.jsp">Update Product</a></li>
  <li class="nav-item"><a class="nav-link" href="RegisteredProducts.jsp">Registered Products</a></li>
  <li class="nav-item"><a class="nav-link active" href="SearchUsers.jsp">Users</a></li>
  <li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
</ul>

 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
<form action="" method="post">
<h1 style ="text-align: center">Users</h1>
<input type="hidden" name="submitted" value="true">

<table class="table-borderless" style="margin : 0px auto;">
<tr>
<td><select name="typeofSearch" class="form-control">
<option value="username">Username</option><option value="phone">Phone</option><option value="email">Email</option>
</select></td>
<td colspan="2"><input type="text" class="form-control" name="searchData"/></td>
<td><input type="submit" value="Search" class= "btn btn-info" name="search"/></td>
</tr>
</table>

<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from users;
   </sql:query>


<c:if test="${param.submitted and not empty param.searchData }">
<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from users where ${param.typeofSearch }='${param.searchData}';
   </sql:query>
</c:if>

<c:choose>
<c:when test="${usersDetails.rowCount==0 }">
<div class="alert alert-danger" role="alert" style="margin : 10px auto;"><c:out value="No records found!" /></div>
</c:when>
<c:otherwise>
<table class="table-bordered table-striped" style="margin : 10px auto;">
<tr><th>UserName</th><th>Phone Number</th><th>Email</th><th>Full name</th>
</tr>
<c:forEach var="row" items="${usersDetails.rows }">
<tr>
<td>${row.username }</td><td>${row.phone }</td><td>${row.email}</td><td>${row.name }</td>
</tr>
</c:forEach>
</table>
</c:otherwise>
</c:choose>
</form>
</body>
</html>