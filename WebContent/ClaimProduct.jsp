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
<link rel="stylesheet" href="css/bootstrap.min.css"/>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
.btn-info{
width: 200px;
margin-top :20px;
}
form{ 
padding: 10px; 
text-align: center; 
margin: 60px auto;
}
</style>
</head>
<body>
<ul class="nav nav-tabs justify-content-center">
  <li class="nav-item"><a class="nav-link" href="UserDashboard.jsp">Home</a></li>
  <li class="nav-item"><a class="nav-link" href="RegisterProduct.jsp">Register Product</a></li>
  <li class="nav-item"><a class="nav-link active" href="ClaimProduct.jsp">Claim Product</a></li>
  <li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
</ul>

<form action="ClaimProductdb.jsp" method="post">
<h1 style ="text-align: center">Claim Product Form</h1>
<input type="hidden" name="submitted" value="true">
 <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
                           
<sql:query dataSource="${dbsource}" var="regProducts">
       SELECT * from registeredproducts where username='${cookie.currentUser.value}';
   </sql:query>

<table class="table-bordered table-striped" style="margin : 0px auto;">
<tr><th>Product Name</th><th>Serial Number</th><th>Purchase Date</th><th>Issue</th><th>Click to claim</th>
</tr>

<c:forEach var="row" items="${regProducts.rows }">
<sql:query dataSource="${dbsource}" var="productIds">
       SELECT pname from product where pId='${row.pId}';
   </sql:query>
<c:forEach var="rowx" items="${productIds.rows }">
<tr>
<td>${rowx.pname }</td><td>${row.serialNo}</td><td>${row.purchaseDate }</td><td><textarea rows="2" cols="25" class="form-control" name="issue"></textarea></td>
<td><input type="radio" name="radiogroup" value="${row.pId},${row.serialNo },${row.purchaseDate }"/></td>
</tr>
</c:forEach>
</c:forEach>
</table>
<input type="submit" value="Claim Product" class= "btn btn-info" name="claim"/>

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