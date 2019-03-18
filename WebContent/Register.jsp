<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
<h1 style ="text-align: center">Register Form</h1>
<form action="" method="post" style="width: 400px; border: 1px solid black; text-align: center; padding: 10px;">
<p>User name : <input type="text" name="username" required/></p>
<p>Password : <input type="password" name="password" required/><p>
<p>Phone Number : <input type="text" name="phone" required/></p>
<p>Email : <input type="text" name="email" required/><p>
<p>Name : <input type="text" name="name"/></p>

<input type="submit" value="Register" name="register"/>
</form>
</body>
</html>