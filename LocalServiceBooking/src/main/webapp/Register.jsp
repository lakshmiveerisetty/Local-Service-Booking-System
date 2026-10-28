<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register - Local Service Booking</title>

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
    padding: 20px;
}

.register-container {
    background: white;
    width: 400px;
    max-width: 100%;
    padding: 30px;
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
    margin-bottom: 17px;
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
    <div class="register-container">

        <h2>Create Account</h2>
        <div class="subtitle">Join our Local Service Booking System</div>

        <form action="RegisterServlet" method="post">

            <label for="name">Full Name</label>
            <input type="text" id="name" name="name"
                   placeholder="Enter your full name" required>

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   placeholder="Enter your email" required>

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone"
                   placeholder="Enter your phone number"
                   pattern="[0-9]{10}" maxlength="10" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Create a password"
                   minlength="8" required>

            <button type="submit">Register</button>

        </form>

        <p>Already have an account?
            <a href="Login.jsp">Login here</a>
        </p>

        <p><a href="Index.jsp">Back to Home</a></p>

    </div>
</body>
</html>