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
<title>Add Product</title>
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
		<li class="nav-item"><a class="nav-link active"
			href="AddProduct.jsp">Add Product</a></li>
		<li class="nav-item"><a class="nav-link"
			href="UpdateProducts.jsp">Update Product</a></li>
		<li class="nav-item"><a class="nav-link"
			href="RegisteredProducts.jsp">Registered Products</a></li>
		<li class="nav-item"><a class="nav-link" href="SearchUsers.jsp">Users</a></li>
		<li class="nav-item"><a class="nav-link" href="Login.jsp">Logout</a></li>
	</ul>

	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />


	<form action="AddProductdb.jsp" method="post">
		<h1 style="text-align: center">Add Product</h1>
		<input type="hidden" name="submitted" value="true">
		<table class="table-borderless" style="margin: 0px auto">
			<tr>
				<th>Product Name :</th>
				<td><input type="text" class="form-control" name="pname" /></td>
			</tr>
			<tr>
				<th>Color :</th>
				<td><input type="text" class="form-control" name="color" /></td>
			</tr>
			<tr>
				<th>Model :</th>
				<td><input type="text" class="form-control" name="model" /></td>
			</tr>
			<tr>
			<tr>
				<td colspan="2"><input type="submit" value="Add"
					class="btn btn-info" name="register" /></td>
			</tr>
		</table>

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