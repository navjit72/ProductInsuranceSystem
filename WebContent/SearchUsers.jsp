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
<link rel="stylesheet" href="file1.css">
<style>
.search{
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
.searchCriteria th, .searchCriteria td{
border : none;
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
<h1 style ="text-align: center">Users</h1>
<input type="hidden" name="submitted" value="true">

<table class="searchCriteria" style="margin : 0px auto;">
<tr>
<td><select name="typeofSearch">
<option value="username">Username</option><option value="phone">Phone</option><option value="email">Email</option>
</select></td>
<td colspan="2"><input type="text" name="searchData"/></td>
<td><input type="submit" value="Search" class= "search" name="search"/></td>
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

<table style="margin : 0px auto;border: 1px solid black;">
<tr><th>UserName</th><th>Phone Number</th><th>Email</th><th>Full name</th>
</tr>
<c:forEach var="row" items="${usersDetails.rows }">
<tr>
<td>${row.username }</td><td>${row.phone }</td><td>${row.email}</td><td>${row.name }</td>
</tr>
</c:forEach>
</table>

<%-- <c:choose>
<c:when test="${param.submitted2 and empty param.radiogroup}">
<font color="red"><c:out value="No user selected!" /></font>
</c:when>
<c:when test="${param.submitted2 and not empty param.radiogroup}">
<sql:query dataSource="${dbsource}" var="usersProducts">
       SELECT * from registeredproducts where username='${param.radiogroup }';
   </sql:query>
<table style="margin : 20px auto;border: 1px solid black;">
<tr><th>Product Name</th><th>Serial Number</th><th>Purchased Date</th>
</tr>
<c:forEach var="row" items="${usersProducts.rows }">
<sql:query dataSource="${dbsource}" var="products">
       SELECT pname from product where pId='${row.pId }';
</sql:query>
<c:forEach var="rowx" items="${products.rows }">
<tr>
<td>${rowx.pname }</td><td>${row.serialNo}</td><td>${row.purchaseDate}</td>
</tr>
</c:forEach>
</c:forEach>
</table>
</c:when>
</c:choose> --%>

</form>
</body>
</html>