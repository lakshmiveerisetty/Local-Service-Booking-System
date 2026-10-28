
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("resetUserId") == null
        || session.getAttribute("resetOtp") == null) {
    response.sendRedirect("ForgotPassword.jsp");
    return;
}

String demoOtp = (String) session.getAttribute("demoOtp");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>

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

        input {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background: #243b64;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .demo {
            padding: 12px;
            margin: 15px 0;
            text-align: center;
            background: #fff4d6;
            border-radius: 5px;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>

<body>

    <h1>Verify OTP</h1>

    <div class="box">

        <p>Enter the six-digit OTP to continue password recovery.</p>

        <div class="demo">
            <strong>Demo OTP: <%= demoOtp %></strong>
            <p>For project testing only. No email or SMS was sent.</p>
        </div>

        <% if ("invalid".equals(error)) { %>
            <p class="error">Incorrect or expired OTP. Please try again.</p>
        <% } %>

        <form action="VerifyOTPServlet" method="post">

            <label for="otp">Enter OTP</label>

            <input type="text"
                   id="otp"
                   name="otp"
                   inputmode="numeric"
                   pattern="[0-9]{6}"
                   maxlength="6"
                   placeholder="Enter 6-digit OTP"
                   required>

            <button type="submit">Verify OTP</button>

        </form>

    </div>

</body>
</html>