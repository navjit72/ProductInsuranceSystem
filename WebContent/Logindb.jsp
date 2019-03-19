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
<c:if test="${ empty param.username or empty param.password}">
            <c:redirect url="Login.jsp" >
                <c:param name="errMsg" value="Please fill username and password" />
            </c:redirect>
 
        </c:if>
        <sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
 
 
        <sql:query dataSource="${dbsource}" var="result">
            SELECT * from users where username='${param.username}' and password='${param.password}';
        </sql:query>
               
        <c:if test="${result.rowCount!=0}">            
            <c:redirect url="Login.jsp" >
                <c:param name="susMsg" value="Login in successfull." />
            </c:redirect>
        </c:if>
        <c:if test="${result.rowCount == 0}">
            <c:redirect url="Login.jsp" >
                <c:param name="errMsg" value="User not found" />
            </c:redirect>
        </c:if>
 
</body>
</html>