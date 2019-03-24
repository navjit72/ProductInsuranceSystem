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
<title>Update Product</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
form {
	padding: 10px;
	text-align: center;
	margin: 80px auto;
}

.btn-info {
	width: 200px;
	margin-top: 20px;
}
</style>
</head>
<body>
	<ul class="nav nav-tabs justify-content-center">
		<li class="nav-item"><a class="nav-link"
			href="AdminDashboard.jsp">Home</a></li>
		<li class="nav-item"><a class="nav-link" href="AddProduct.jsp">Add
				Product</a></li>
		<li class="nav-item"><a class="nav-link active"
			href="UpdateProducts.jsp">Update Product</a></li>
		<li class="nav-item"><a class="nav-link"
			href="RegisteredProducts.jsp">Registered Products</a></li>
		<li class="nav-item"><a class="nav-link" href="SearchUsers.jsp">Users</a></li>
		<li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
	</ul>

	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />


	<form action="" method="post">
		<h1 style="text-align: center">Update Product</h1>
		<input type="hidden" name="submitted" value="true">
		<sql:query dataSource="${dbsource}" var="productDetails">
       SELECT * from product;
   </sql:query>

		<table class="table-bordered table-striped" style="margin: 0px auto;">
			<tr>
				<th>Product Name</th>
				<th>Color</th>
				<th>Model</th>
				<th>Click to Update</th>
			</tr>

			<c:forEach var="row" items="${productDetails.rows }">

				<tr>
					<td>${row.pname }</td>
					<td>${row.color}</td>
					<td>${row.model }</td>
					<td><input type="radio" name="radiogroup"
						value="${row.pId},${row.pname },${row.color},${row.model }" /></td>
				</tr>
			</c:forEach>

		</table>
		<input type="submit" value="Update Product" class="btn btn-info"
			name="update" />
	</form>

	<form action="UpdateProductsdb.jsp" method="">
		<input type="hidden" name="submitted2" value="true" />

		<c:choose>
			<c:when test="${param.submitted and empty param.radiogroup}">
				<div class="alert alert-danger" role="alert">
					<c:out value="No Product selected!" />
				</div>
			</c:when>
			<c:when test="${param.submitted and not empty param.radiogroup}">
				<c:set var="data" value="${fn:split(param.radiogroup,',') }" />
				<table class="table-bordered table-striped"
					style="margin: 0px auto;">
					<tr>
						<th>Product Name</th>
						<th>Color</th>
						<th>Model</th>
					</tr>
					<tr>
						<td><input type="hidden" value="${data[0]}" name="id" /> <input
							type="text" value="${data[1]}" name="pname" class="form-control" /></td>
						<td><input type="text" value="${data[2]}" name="color"
							class="form-control" /></td>
						<td><input type="text" value="${data[3]}" name="model"
							class="form-control" /></td>
					</tr>
				</table>
				<input type="submit" value="Update Product Info"
					class="btn btn-info" name="update" />
			</c:when>
		</c:choose>

		<div style="margin-top: 40px;">
			<c:if test="${not empty param.errMsg}">
				<div class="alert alert-danger" role="alert">
					<c:out value="${param.errMsg}" />
				</div>
			</c:if>
			<c:if test="${not empty param.susMsg}">
				<div class="alert alert-success" role="alert">
					<c:out value="${param.susMsg}" />
				</div>
			</c:if>
		</div>

	</form>
</body>
</html>