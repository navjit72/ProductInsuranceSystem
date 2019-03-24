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
<title>Update status</title>
</head>
<body>
	<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://bgrt8ztyyfrg23qifg66-mysql.services.clever-cloud.com/bgrt8ztyyfrg23qifg66" 
		user="uj3aqvvxbcwqdgu9" password="dXgTyr43Rt8AykoIx3pb" />
	<sql:update dataSource="${dbsource}" var="updateStatus">
	UPDATE claims SET status=? where claimId=?;
            <sql:param value="${param.status}" />
		<sql:param value="${param.id}" />

	</sql:update>

	<c:if test="${updateStatus>=1}">
		<font size="5" color='green'> Congratulations ! Data updated
			successfully.</font>
		<c:redirect url="AdminDashboard.jsp">
			<c:param name="susMsg" value="Claim status updated successfully" />
		</c:redirect>
	</c:if>
</body>
</html>