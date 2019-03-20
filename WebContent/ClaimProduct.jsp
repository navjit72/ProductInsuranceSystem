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
<title>Claim Product</title>
<style>
.claim{
text-align: center;
border-radius: 5px;
font-weight: bold;
margin : 10px;
padding-top : 5px;
width : 120px;
height : 25px;
}
form{
width: 500px;
border: 1px solid black; 
padding: 10px; 
text-align: center; 
margin: 100px auto;
}
table input, table select {
width : 200px;
}
nav{
background-color: black;
color: white;
text-decoration: none;
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
  <li><a href="RegisterProduct.jsp">Home</a></li>
  <li><a href="RegisterProduct.jsp">Register Product</a></li>
  <li><a href="ClaimProduct.jsp">Claim Product</a></li>
  <li><a href="Login.jsp">Logout</a></li>
</ul>

<form action="ClaimProductdb.jsp" method="post">
<h1 style ="text-align: center">Claim Product Form</h1>
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
            SELECT pname from product where pId = (select pId from registeredproducts where username='${sessionScope.username}');
        </sql:query>
<c:forEach var="row" items="${result.rows}">
<option><c:out value="${row.pname}"/></option>
</c:forEach>
</select></td>
</tr>
<tr>
<th>Issue : </th>
<td><textarea rows="3" cols="25" name="issue"></textarea></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="Claim Product" class= "claim" name="claim"/></td>
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