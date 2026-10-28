
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
String updated = request.getParameter("updated");

if (!"success".equals(updated)
        && (session.getAttribute("resetUserId") == null
        || !Boolean.TRUE.equals(session.getAttribute("otpVerified")))) {

    response.sendRedirect("ForgotPassword.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
            margin: 0;
            padding: 25px;
        }

        h1 {
            text-align: center;
            color: #243b64;
        }

        .box {
            width: 100%;
            max-width: 400px;
            margin: 30px auto;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-sizing: border-box;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 11px;
            margin-top: 7px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            margin-top: 22px;
            padding: 12px;
            background: #243b64;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .message {
            text-align: center;
            margin-bottom: 15px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }
    </style>
</head>

<body>

    <h1>Reset Password</h1>

    <div class="box">

        <% if ("mismatch".equals(error)) { %>
            <p class="message error">
                Passwords do not match.
            </p>
        <% } else if ("short".equals(error)) { %>
            <p class="message error">
                Password must contain at least 8 characters.
            </p>
        <% } else if ("failed".equals(error)) { %>
            <p class="message error">
                Password reset failed. Please try again.
            </p>
        <% } else if ("success".equals(updated)) { %>
            <p class="message success">
                Password reset successfully!
            </p>
            <p class="message">
                <a href="Login.jsp">Go to Login</a>
            </p>
        <% } %>

        <% if (!"success".equals(updated)) { %>

        <form action="ResetPasswordServlet" method="post">

            <label>New Password</label>
            <input type="password"
                   name="newPassword"
                   minlength="8"
                   required>

            <label>Confirm New Password</label>
            <input type="password"
                   name="confirmPassword"
                   minlength="8"
                   required>

            <button type="submit">Reset Password</button>

        </form>

        <% } %>

    </div>

</body>
</html>