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
<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from claims;
   </sql:query>

<table style="margin : 0px auto;border: 1px solid black;">
<tr><th>UserName</th><th>Product Name</th><th>Serial Number</th><th>Purchased Date</th><th>Claimed Date</th><th>Issue</th><th>Status</th><th>Click to Update</th>
</tr>

<c:forEach var="row" items="${usersDetails.rows }">
<sql:query dataSource="${dbsource}" var="productIds">
       SELECT pname from product where pId='${row.pId}';
   </sql:query>
<c:forEach var="rowx" items="${productIds.rows }">
<tr>
<td>${row.username }</td><td>${rowx.pname }</td><td>${row.serialNo}</td><td>${row.pDate }</td><td>${row.claimDate }</td><td>${row.issue }</td><td>${row.status }</td>
<td><input type="radio" name="radiogroup" value="${row.username },${row.pId},${row.serialNo },${row.pDate },${row.claimDate },${row.issue },${row.status }"/></td>
</tr>
</c:forEach>
</c:forEach>
<tr>
<td colspan="8"><input type="submit" value="Display Info" class= "update" name="display"/></td>
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
<table style="margin : 30px auto;border: 1px solid black;">
<tr><th>Claim Date</th><th>Issue</th><th>Status</th>
</tr>
<tr>
<td>${data[4]}</td><td>${data[5]}</td>
<td><select name="status">
<option>Processing</option>
<option>Accepted</option>
<option>Rejected</option>
</select></td>
</tr>
<tr>
<td colspan="3"><input type="submit" value="Update Claim Info" class= "update" name="update"/></td>
</tr>
</table>
</c:when>
</c:choose>

<c:if test="${param.submitted2 }">
<sql:update dataSource="${dbsource}" var="updateStatus">
	UPDATE claims SET status=? where username=? and pId=? and serialNo=? and pDate=?;
            <sql:param value="${param.status}" />
            <sql:param value="${data[0]}" />
            <sql:param value="${data[1]}" />
            <sql:param value="${data[2]}" />
            <sql:param value="${data[3]}" />
        </sql:update>
	<c:if test="${updateStatus>=1}">
            <font size="5" color='green'> Congratulations ! Data updated
            successfully.</font>
        </c:if>
</c:if>

</form>
</body>
</html>