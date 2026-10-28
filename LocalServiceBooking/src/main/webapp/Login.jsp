<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Local Service Booking</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #dbeafe, #eff6ff);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.login-container {
    background: white;
    width: 360px;
    max-width: 92%;
    padding: 35px;
    border-radius: 12px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.12);
}

h2 {
    text-align: center;
    color: #1d4ed8;
    margin-bottom: 10px;
}

.subtitle {
    text-align: center;
    color: #666;
    font-size: 14px;
    margin-bottom: 25px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
    color: #333;
}

input {
    width: 100%;
    padding: 11px;
    margin-bottom: 18px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
}

input:focus {
    outline: none;
    border-color: #2563eb;
}

button {
    width: 100%;
    padding: 12px;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}

button:hover {
    background: #1d4ed8;
}

p {
    text-align: center;
    margin-top: 18px;
    font-size: 14px;
}

a {
    color: #2563eb;
    text-decoration: none;
    font-weight: bold;
}
</style>
</head>

<body>
    <div class="login-container">

        <h2>Welcome Back!</h2>
        <div class="subtitle">Login to book local services</div>

        <form action="LoginServlet" method="post">

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter your password" required>

            <button type="submit">Login</button>
            <p style="text-align: center; margin-top: 15px;">
    <a href="ForgotPassword.jsp">Forgot Password?</a>
</p>
        </form>

        <p>Don't have an account?
            <a href="Register.jsp">Register here</a>
        </p>

        <p><a href="Index.jsp">Back to Home</a></p>

    </div>
</body>
</html>