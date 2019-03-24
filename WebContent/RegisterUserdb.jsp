<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert User</title>
</head>
<body>
	<c:if
		test="${ empty param.username or empty param.password or empty param.phone or empty param.email}">
		<c:redirect url="Register.jsp">
			<c:param name="errMsg"
				value="Username, password, phone and email are required firelds" />
		</c:redirect>

	</c:if>
	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />


	<sql:update dataSource="${dbsource}" var="result">
            INSERT INTO users VALUES (?,?,?,?,?);
            <sql:param value="${param.username}" />
		<sql:param value="${param.password}" />
		<sql:param value="${param.phone}" />
		<sql:param value="${param.email}" />
		<sql:param value="${param.name}" />

	</sql:update>

	<c:if test="${result>=1}">
		<font size="5" color='green'> Congratulations ! Data inserted
			successfully.</font>

		<c:redirect url="Register.jsp">
			<c:param name="susMsg"
				value="Congratulations ! Data inserted
            successfully." />
		</c:redirect>
	</c:if>

</body>
</html>