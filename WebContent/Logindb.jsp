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
                       
        <c:choose>
        
        <c:when test="${param.username.startsWith('A')}">
        <sql:query dataSource="${dbsource}" var="adminResult">
            SELECT * from admin where adminId='${param.username}' and password='${param.password}';
        </sql:query>
        <c:if test="${adminResult.rowCount == 0}">
            <c:redirect url="Login.jsp" >
                <c:param name="errMsg" value="Admin not found" />
            </c:redirect>
        </c:if>
         <c:if test="${adminResult.rowCount!=0}">
         
         <c:set var="username" value="${param.username}" scope="session" />
         <%Cookie logincookie = new Cookie("currentAdmin",request.getParameter("username")) ;
        	logincookie.setMaxAge(30*60);
        	response.addCookie(logincookie);     
        %>  
        	<c:redirect url="AdminDashboard.jsp" >             
            </c:redirect>
       	</c:if>
        </c:when>
        <c:otherwise>
          
        <sql:query dataSource="${dbsource}" var="result">
            SELECT * from users where username='${param.username}' and password='${param.password}';
        </sql:query>
               
        <c:if test="${result.rowCount!=0}">
        	<c:set var="username" value="${param.username}" scope="session" />
        	<%Cookie logincookie = new Cookie("currentUser",request.getParameter("username")) ;
        	logincookie.setMaxAge(30*60);
        	response.addCookie(logincookie);     
        	%>
        	            
            <c:redirect url="UserDashboard.jsp" >
                
            </c:redirect>
        </c:if>
        <c:if test="${result.rowCount == 0}">
            <c:redirect url="Login.jsp" >
                <c:param name="errMsg" value="User not found" />
            </c:redirect>
        </c:if>
        </c:otherwise>
        </c:choose>
       
</body>
</html>