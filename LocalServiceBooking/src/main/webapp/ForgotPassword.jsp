
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

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
            max-width: 420px;
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

        input, select {
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

        button:hover {
            background: #173e68;
        }

        .bottom {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #2457a7;
            text-decoration: none;
        }
    </style>
</head>

<body>

    <h1>Forgot Password</h1>

    <div class="box">

        <p>Choose how you want to receive your verification OTP.</p>

        <form action="ForgotPasswordServlet" method="post">

            <label>Registered Email Address</label>
            <input type="email" name="email"
                   placeholder="Enter your registered email"
                   required>

            <label>OTP Verification Method</label>
            <select name="method" required>
                <option value="">-- Select Method --</option>
                <option value="email">Email OTP</option>
                <option value="mobile">Mobile OTP</option>
            </select>

            <button type="submit">Send OTP</button>

        </form>

        <div class="bottom">
            <a href="Login.jsp">Back to Login</a>
        </div>

    </div>

</body>
</html>