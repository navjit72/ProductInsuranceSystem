<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert Product</title>
</head>
<body>
	<c:if test="${ empty param.serialNo or empty param.pDate}">
		<c:redirect url="RegisterProduct.jsp">
			<c:param name="errMsg"
				value="Serial Number and purchase date are required firelds" />
		</c:redirect>

	</c:if>
	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />

	<sql:query dataSource="${dbsource}" var="product">
       		Select pId from product where pname='${param.pname }';
       </sql:query>

	<c:forEach var="row" items="${product.rows}">
		<sql:query dataSource="${dbsource}" var="registerDetails">
       		Select * from registeredproducts where username='${cookie.currentUser.value}' and pId='${row.pId }' and serialNo='${param.serialNo }' and purchaseDate='${param.pDate}';
       </sql:query>
		<c:choose>
			<c:when test="${registerDetails.rowCount>0 }">
				<c:redirect url="RegisterProduct.jsp">
					<c:param name="errMsg" value="Product already registered!!." />
				</c:redirect>
			</c:when>
			<c:otherwise>
				<sql:update dataSource="${dbsource}" var="result">
            INSERT INTO registeredproducts VALUES (?,?,?,?);
            <sql:param value="${cookie.currentUser.value}" />
					<sql:param value="${row.pId}" />
					<sql:param value="${param.serialNo}" />
					<sql:param value="${param.pDate}" />

				</sql:update>

				<c:if test="${result>=1}">
					<font size="5" color='green'> Congratulations ! Data
						inserted successfully.</font>

					<c:redirect url="RegisterProduct.jsp">
						<c:param name="susMsg"
							value="Congratulations ! Data inserted
            successfully." />
					</c:redirect>
				</c:if>
			</c:otherwise>
		</c:choose>
	</c:forEach>

</body>
</html>