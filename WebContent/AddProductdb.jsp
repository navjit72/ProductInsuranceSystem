<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Product</title>
</head>
<body>
		<c:if test="${ empty param.pname}">
            <c:redirect url="AddProduct.jsp" >
                <c:param name="errMsg" value="Product Name is a required fireld" />
            </c:redirect>
 
        </c:if>
        <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
        <sql:update dataSource="${dbsource}" var="updateStatus">
	Insert into product(pname,color,model) values(?,?,?);
            <sql:param value="${param.pname}" />
            <sql:param value="${param.color}" />
            <sql:param value="${param.model}" />
        </sql:update>
	<c:if test="${updateStatus>=1}">
            <font size="5" color='green'> Congratulations ! Data inserted
            successfully.</font>
            <c:redirect url="AddProduct.jsp" >
                <c:param name="susMsg" value="Product inserted successfully" />
            </c:redirect>
        </c:if>
</body>
</html>