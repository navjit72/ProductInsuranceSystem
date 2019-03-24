<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registered Products</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
form {
	padding: 10px;
	text-align: center;
	margin: 100px auto;
}

.btn-info {
	width: 200px;
}
</style>
</head>
<body>
	<ul class="nav nav-tabs justify-content-center">
		<li class="nav-item"><a class="nav-link"
			href="AdminDashboard.jsp">Home</a></li>
		<li class="nav-item"><a class="nav-link" href="AddProduct.jsp">Add
				Product</a></li>
		<li class="nav-item"><a class="nav-link"
			href="UpdateProducts.jsp">Update Product</a></li>
		<li class="nav-item"><a class="nav-link active"
			href="RegisteredProducts.jsp">Registered Products</a></li>
		<li class="nav-item"><a class="nav-link" href="SearchUsers.jsp">Users</a></li>
		<li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
	</ul>

	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />
	<form action="" method="post">
		<h1 style="text-align: center">Registered Products</h1>
		<input type="hidden" name="submitted" value="true">

		<table class="table-borderless" style="margin: 20px auto;">
			<tr>
				<td><select name="typeofSearch" class="form-control">
						<option value="username">UserName</option>
						<option value="pname">Product Name</option>
						<option value="serialNo">Serial Number</option>
						<option value="purchaseDate">Purchase Date</option>
				</select></td>
				<td colspan="2"><input type="text" class="form-control"
					name="searchData" /></td>

				<td><input type="submit" value="Search" class="btn btn-info"
					name="search" /></td>
			</tr>
		</table>


		<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from registeredproducts;
   </sql:query>

		<c:if test="${param.submitted and not empty param.searchData}">
			<c:choose>
				<c:when test="${param.typeofSearch ne 'pname' }">
					<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from registeredproducts where ${param.typeofSearch }='${param.searchData}';
   </sql:query>
				</c:when>

				<c:when test="${param.typeofSearch eq 'pname' }">
					<sql:query dataSource="${dbsource}" var="product">
       SELECT pId from product where pname='${param.searchData}';
   </sql:query>
					<c:forEach var="rowz" items="${product.rows }">
						<sql:query dataSource="${dbsource}" var="usersDetails">
       SELECT * from registeredproducts where pId='${rowz.pId}';
   </sql:query>
					</c:forEach>
				</c:when>
			</c:choose>

		</c:if>

		<c:choose>
			<c:when test="${usersDetails.rowCount==0 }">
				<div class="alert alert-danger" role="alert">
					<c:out value="No records found!" />
				</div>
			</c:when>
			<c:when test="${product.rowCount==0 }">
				<div class="alert alert-danger" role="alert">
					<c:out value="No such product found!" />
				</div>
			</c:when>
			<c:otherwise>
				<table class="table-bordered table-striped"
					style="margin: 10px auto;">
					<tr>
						<th>UserName</th>
						<th>Product Name</th>
						<th>Serial Number</th>
						<th>Purchased Date</th>
					</tr>
					<c:forEach var="row" items="${usersDetails.rows }">
						<sql:query dataSource="${dbsource}" var="products">
       SELECT pname from product where pId='${row.pId}';
   </sql:query>
						<c:forEach var="rowx" items="${products.rows }">
							<tr>
								<td>${row.username }</td>
								<td>${rowx.pname }</td>
								<td>${row.serialNo}</td>
								<td>${row.purchaseDate }</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</table>
			</c:otherwise>
		</c:choose>

	</form>
</body>
</html>