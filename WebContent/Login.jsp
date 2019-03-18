<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<center>
<h1 style ="text-align: center">Login Form</h1>
<form action="" method="post" style="width: 400px; border: 1px solid black; padding: 10px;">

<input type="hidden" name="submitted" value="true">
<c:if test="${(param.submitted && empty param.username) || (param.submitted && empty param.password)}">
<h3 style="color: red;">Please fill username and password</h3>
</c:if>
<p>User name : <input type="text" name="username"/></p>
<p>Password : <input type="password" name="password"/><p>
<input type="submit" value="Login" name="login"/>

</form>


<c:if test="${param.submitted && not empty param.username && not empty param.password }">
<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
 <sql:query dataSource="${dbsource}" var="result">
            SELECT * from users where username='${param.username}' and password='${param.password}';
        </sql:query>
        <c:choose>
        <c:when test="${result.rowCount == 0 }">
        <c:out value="User not registered. Please go back to register."></c:out>
        </c:when>
        <c:otherwise>
        <c:redirect url="RegisterProduct.jsp" >
                <c:set scope="session"
                   var="loginUser"
                   value="${param.username}"/>
        </c:redirect>
        </c:otherwise>
        </c:choose>
</c:if>
</center>
<a href="MainPage.jsp">Go To Main Page</a>

</body>
</html>