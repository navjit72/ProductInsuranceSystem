<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
Cookie loginCookie = null;
Cookie[] cookies = request.getCookies();
if(cookies != null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("currentAdmin")){
		loginCookie = cookie;
		break;
	}
	else if(cookie.getName().equals("currentUser")){
		loginCookie = cookie;
		break;
	}
}
}
if(loginCookie != null){
	loginCookie.setMaxAge(0);
	response.addCookie(loginCookie);
}
response.sendRedirect("Login.jsp");

%>
</body>
</html>