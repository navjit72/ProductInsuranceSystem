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
            <c:redirect url="RegisterProduct.jsp" >
                <c:param name="errMsg" value="Serial Number and purchase date are required firelds" />
            </c:redirect>
 
        </c:if>
        <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
       
       <sql:query dataSource="${dbsource}" var="product">
       		Select pId from product where pname='${param.pname }';
       </sql:query> 
 		<c:forEach var="row" items="${product.rows}">
        <sql:update dataSource="${dbsource}" var="result">
            INSERT INTO registeredproducts VALUES (?,?,?,?);
            <sql:param value="${sessionScope.username}" />
            <sql:param value="${row.pId}" />
            <sql:param value="${param.serialNo}" />
            <sql:param value="${param.pDate}" />

        </sql:update>
        </c:forEach>
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