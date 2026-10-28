<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") == null ||
        !"ADMIN".equalsIgnoreCase(
            String.valueOf(session.getAttribute("userRole")))) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Service</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f5f9;
            margin: 0;
            padding: 30px;
        }

        .container {
            width: 400px;
            margin: 30px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            text-align: center;
            color: #263b5e;
        }

        label {
            display: block;
            margin-top: 15px;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background: #263b5e;
            color: white;
            border: none;
            cursor: pointer;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>

<body>
    <div class="container">
    <%
    String success = request.getParameter("success");
    String error = request.getParameter("error");

    if ("1".equals(success)) {
%>
    <p style="color: green; text-align: center;">
        Service added successfully!
    </p>
<%
    } else if (error != null) {
%>
    <p style="color: red; text-align: center;">
        Failed to add service. Please check the details and try again.
    </p>
<%
    }
%>
        <h2>Add New Service</h2>

        <form action="AddServiceServlet" method="post">

            <label>Service Name</label>
            <input type="text" name="serviceName" required>

            <label>Description</label>
            <textarea name="description" rows="3" required></textarea>

            <label>Price (₹)</label>
            <input type="number" name="price"
                   min="0.01" step="0.01" required>

            <label>Category</label>
            <select name="category" required>
                <option value="">Select Category</option>
                <option value="Home Repair">Home Repair</option>
                <option value="Cleaning">Cleaning</option>
                <option value="Electrical">Electrical</option>
                <option value="Plumbing">Plumbing</option>
                <option value="Other">Other</option>
            </select>

            <button type="submit">Add Service</button>
        </form>

        <a class="back" href="AdminDashboardServlet">
            Back to Admin Dashboard
        </a>
    </div>
</body>
</html>