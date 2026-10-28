<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("userId") != null
        && "ADMIN".equals(session.getAttribute("userRole"))) {
    response.sendRedirect("AdminDashboardServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f2f6fc;
    margin: 0;
}
.container {
    width: 350px;
    margin: 100px auto;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 3px 10px #ccc;
}
h2 {
    text-align: center;
    color: #243b64;
}
label {
    display: block;
    margin-top: 15px;
}
input {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    box-sizing: border-box;
}
button {
    width: 100%;
    margin-top: 20px;
    padding: 12px;
    background: #243b64;
    color: white;
    border: none;
    cursor: pointer;
}
</style>
</head>

<body>
<div class="container">
    <h2>Admin Login</h2>

    <form action="AdminLoginServlet" method="post">
        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit">Login as Admin</button>
    </form>
</div>
</body>
</html>