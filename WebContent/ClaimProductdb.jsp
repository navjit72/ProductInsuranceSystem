<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	
       <sql:query dataSource="${dbsource}" var="productId">
       		Select pId from product where pname='${param.pname }';
       </sql:query> 
       
       <c:forEach var="row" items="${productId.rows}">
       
       <sql:query dataSource="${dbsource }" var="claimDetails">
		Select * from claims where username='${sessionScope.username}' and pId='${row.pId}';
		</sql:query>
		
		<sql:query dataSource="${dbsource}" var="productDate">
       		Select purchaseDate from registeredproducts where pId='${row.pId }' and username='${sessionScope.username}';
       </sql:query>
       
       <fmt:parseNumber value="${ currentDate.time / (1000*60*60*24*365) }" integerOnly="true" var="nowDays" />

		<fmt:parseNumber value="${ rowx.purchaseDate.time / (1000*60*60*24*365) }" integerOnly="true" var="otherDays" />
       
      <c:forEach var="rowx" items="${productDate.rows}">
      <c:choose>
    
      <c:when test="${claimDetails.rowCount lt '3'}">
            
        <sql:update dataSource="${dbsource}" var="result">
            INSERT INTO claims(username,pId,pDate,claimDate,issue) VALUES (?,?,?,?,?);
            <sql:param value="${sessionScope.username}" />
            <sql:param value="${row.pId}" />
            <sql:param value="${rowx.purchaseDate}" />
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
      </c:forEach>
      </c:forEach>

</body>
</html>