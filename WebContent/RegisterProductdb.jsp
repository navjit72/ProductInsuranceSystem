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

        <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
 
 
        <sql:update dataSource="${dbsource}" var="result">
            INSERT INTO registeredproducts VALUES (?,?,?,?,?);
            <sql:param value="${param.username}" />
            <sql:param value="${param.pname}" />
            <sql:param value="${param.serialNo}" />
            <sql:param value="${param.pDate}" />
            <sql:param value="${param.name}" />

        </sql:update>
        
        <c:if test="${result>=1}">
            <font size="5" color='green'> Congratulations ! Data inserted
            successfully.</font>
 
            <c:redirect url="RegisterProduct.jsp" >
                <c:param name="susMsg" value="Congratulations ! Data inserted
            successfully." />
            </c:redirect>
        </c:if>
 
</body>
</html>