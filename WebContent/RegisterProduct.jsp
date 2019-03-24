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
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
.btn-info{
width: 200px;
margin-top :20px;
}
table input, table select{
margin:10px;
}
form{
width: 500px;
border: 1px solid black; 
padding: 10px; 
text-align: center; 
margin: 50px auto;
}
</style>
</head>
<body>
<ul class="nav nav-tabs justify-content-center">
  <li class="nav-item"><a class="nav-link" href="UserDashboard.jsp">Home</a></li>
  <li class="nav-item"><a class="nav-link active" href="RegisterProduct.jsp">Register Product</a></li>
  <li class="nav-item"><a class="nav-link" href="ClaimProduct.jsp">Claim Product</a></li>
  <li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
</ul>

<form action="RegisterProductdb.jsp" method="post">
<h1 style ="text-align: center">Register Product Form</h1>
<input type="hidden" name="submitted" value="true">
<table class="table-borderless" style="margin : 0px auto">
<tr>
<th>User name : </th>
<td><input type="text" class="form-control" disabled="disabled" value="${cookie.currentUser.value}"/></td>
</tr>
<tr>
<th>Product Name :  </th>
<td><select name="pname" class="form-control">
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
<td><input type="text" class="form-control" name="serialNo"/></td>
</tr>
<tr>
<th>Purchase Date : </th>
<c:set var="now" value="<%= new java.util.Date() %>" />
<fmt:formatDate type="date" pattern="yyyy-MM-dd" value="${ now }" var="maxDate" />
<td><input type="date" class="form-control" name="pDate" max="${ maxDate }"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="Register" class= "btn btn-info" name="register"/></td>
</tr>
</table>

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