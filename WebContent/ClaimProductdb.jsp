<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Claim Product</title>
</head>
<body>
<sql:setDataSource var="dbsource" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/groupproject"
                           user="root"  password="1234"/>
                           
     <c:set var="now" value="<%= new java.util.Date() %>" />
    
	<fmt:formatDate type="date" pattern="yyyy-MM-dd" value="${ now }" var="currentDate" />
	<fmt:parseNumber value="${ now.time / (1000*60*60*24*365) }" integerOnly="true" var="currentTime" />
 
     <c:set var="data" value="${fn:split(param.radiogroup,',') }" />
     
     <fmt:parseDate value="${data[2]}" pattern="yyyy-MM-dd" var="parsedDate" />
     
     <sql:query dataSource="${dbsource }" var="claimDetails">
		Select * from claims where username='${sessionScope.username}' and pId='${data[0]}' and serialNo='${data[1]}' and pDate='${data[2]}';
		</sql:query>
     <fmt:parseNumber value="${ parsedDate.time / (1000*60*60*24*365) }" integerOnly="true" var="purchasedTime" />
     
     <c:if test="${not empty param.radiogroup}">
     <c:choose>
    
      <c:when test="${claimDetails.rowCount lt '3' and (currentTime-purchasedTime) lt '5'}">
            
        <sql:update dataSource="${dbsource}" var="result">
            INSERT INTO claims(username,pId,serialNo,pDate,claimDate,issue) VALUES (?,?,?,?,?,?);
            <sql:param value="${sessionScope.username}" />
            <sql:param value="${data[0]}" />
            <sql:param value="${data[1]}" />
            <sql:param value="${data[2]}" />
            <sql:param value="${currentDate}" />
            <sql:param value="${param.issue}" />
        </sql:update>
        
        <c:if test="${result>=1}">
            <font size="5" color='green'> Product claimed successfully.</font>
 
            <c:redirect url="ClaimProduct.jsp" >
                <c:param name="susMsg" value="Product claimed successfully." />
            </c:redirect>
        </c:if>
      </c:when>
      <c:otherwise>
      <c:redirect url="ClaimProduct.jsp" >
                <c:param name="errMsg" value="Product either passed 5 years warranty period or has been already claimed maximum number of times." />
            </c:redirect>
      </c:otherwise>
      </c:choose>
      </c:if>
      <c:if test="${empty param.radiogroup}">
       <c:redirect url="ClaimProduct.jsp" >
                <c:param name="errMsg" value="No product selected" />
      	</c:redirect>
      </c:if>
                           
</body>
</html>