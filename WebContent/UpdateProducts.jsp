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
<title>Products</title>
<style>
.update{
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
  <li><a href="AdminDashboard.jsp">Home</a></li>
  <li><a href="UpdateProducts.jsp">Products</a></li>
  <li><a href="Login.jsp">Logout</a></li>
</ul>

 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
                           
                          
<form action="" method="post">
<h1 style ="text-align: center">Dashboard</h1>
<input type="hidden" name="submitted" value="true">
<sql:query dataSource="${dbsource}" var="productDetails">
       SELECT * from product;
   </sql:query>

<table style="margin : 0px auto;border: 1px solid black;">
<tr><th>Product Name</th><th>Color</th><th>Model</th><th>Click to Update</th>
</tr>

<c:forEach var="row" items="${productDetails.rows }">

<tr>
<td>${row.pname }</td><td>${row.color}</td><td>${row.model }</td>
<td><input type="radio" name="radiogroup" value="${row.pname },${row.color},${row.model }"/></td>
</tr>
</c:forEach>

<tr>
<td colspan="4"><input type="submit" value="Update Product" class= "update" name="update"/></td>
</tr>
</table>
</form>

<form>
<input type="hidden" name="submitted2" value="true" />

<c:choose>
<c:when test="${param.submitted and empty param.radiogroup}">
<font color="red"><c:out value="No Product selected!" /></font>
</c:when>
<c:when test="${param.submitted and not empty param.radiogroup}">
<c:set var="data" value="${fn:split(param.radiogroup,',') }" />
<table style="margin : 20px auto;border: 1px solid black;">
<tr><th>Product Name</th><th>Color</th><th>Model</th>
</tr>
<tr>
<td><input type="text" value="${data[0]}" name="pname"/></td>
<td><input type="text" value="${data[1]}" name="color"/></td>
<td><input type="text" value="${data[2]}" name="model"/></td>
</tr>
<tr>
<td colspan="3"><input type="submit" value="Update Product Info" class= "update" name="update"/></td>
</tr>
</table>
</c:when>
</c:choose>

<c:if test="${param.submitted2 }">
<sql:update dataSource="${dbsource}" var="updateStatus">
	UPDATE product SET pname=? , color=? , model=?  where pname=? and color=? and model=? ;
            <sql:param value="${param.pname}" />
            <sql:param value="${param.color}" />
            <sql:param value="${param.model}" />
            <sql:param value="${data[0]}" />
            <sql:param value="${data[1]}" />
            <sql:param value="${data[2]}" />
        </sql:update>
	<c:if test="${updateStatus>=1}">
            <font size="5" color='green'> Congratulations ! Data updated
            successfully.</font>
        </c:if>
</c:if>

</form>
</body>
</html>