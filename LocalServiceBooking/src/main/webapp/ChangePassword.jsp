
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>

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

        .password-box {
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
            padding: 10px;
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

        button:hover {
            background: #173e68;
        }

        .top {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #2457a7;
            text-decoration: none;
            margin: 10px;
        }
    </style>
</head>

<body>

    <h1>Change Password</h1>
    
<%
String error = request.getParameter("error");
String updated = request.getParameter("updated");

if ("success".equals(updated)) {
%>
    <p style="text-align:center; color:green;">
        Password changed successfully!
    </p>
<%
} else if ("incorrect".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        Current password is incorrect.
    </p>
<%
} else if ("mismatch".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        New password and confirm password do not match.
    </p>
<%
} else if ("short".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        New password must contain at least 8 characters.
    </p>
<%
} else if ("same".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        New password must be different from the current password.
    </p>
<%
} else if ("empty".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        Please fill in all password fields.
    </p>
<%
} else if ("failed".equals(error)) {
%>
    <p style="text-align:center; color:red;">
        Password change failed. Please try again.
    </p>
<%
}
%>

    <div class="password-box">

        <form action="ChangePasswordServlet" method="post">

            <label>Current Password</label>
            <input type="password" name="currentPassword" required>

            <label>New Password</label>
            <input type="password" name="newPassword"
                   minlength="8" required>

            <label>Confirm New Password</label>
            <input type="password" name="confirmPassword"
                   minlength="8" required>

            <button type="submit">Change Password</button>

        </form>

    </div>

    <div class="top">
        <a href="Profile.jsp">My Profile</a>
        <a href="Home.jsp">Home</a>
    </div>

</body>
</html>