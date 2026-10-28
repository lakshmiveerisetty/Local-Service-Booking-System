<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utility.DBConnection" %>

<%
List<String> serviceNames = new ArrayList<>();

try {
    Connection con = DBConnection.getConnection();

    String sql = "SELECT service_name FROM services WHERE active = TRUE ORDER BY service_name";
    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        serviceNames.add(rs.getString("service_name"));
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("Login.jsp");
    return;
}

String serviceName = request.getParameter("service");

if (serviceName == null) {
    serviceName = "Plumbing";
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book a Service</title>

    <style>
    
        body {
            font-family: Arial, sans-serif;
            background: #f2f6fc;
            margin: 0;
            padding: 0;
        }

        header {
            background: #243b64;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            width: 90%;
            max-width: 500px;
            margin: 30px auto;
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
            font-weight: bold;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 7px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
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
            font-size: 16px;
        }

        button:hover {
            background: #36558c;
        }

        nav {
            text-align: center;
            margin: 20px;
        }

        nav a {
            margin: 10px;
            color: #243b64;
            text-decoration: none;
        }
    </style>
</head>

<body>

<header>
    <h1>Local Service Booking System</h1>
    <p>Book trusted services for your home</p>
</header>

<nav>
    <a href="Home.jsp">Home</a>
</nav>

<div class="container">

    <h2>Book a Service</h2>

    <form action="BookServiceServlet" method="post">

        <label>Select Service</label>
       <input type="text" value="<%= serviceName %>" readonly>
<input type="hidden" name="service" value="<%= serviceName %>">

        <label>Booking Date</label>
        <input type="date" id="bookingDate"
               name="bookingDate" required>

        <label>Booking Time</label>
        <input type="time" name="bookingTime" required>

        <label>Service Address</label>
        <textarea name="address" rows="4"
                  placeholder="Enter your full address"
                  required></textarea>

        <button type="submit">Confirm Booking</button>

    </form>

</div>

<script>
    let today = new Date();
    let year = today.getFullYear();
    let month = String(today.getMonth() + 1).padStart(2, '0');
    let day = String(today.getDate()).padStart(2, '0');

    document.getElementById("bookingDate").min =
        year + "-" + month + "-" + day;
</script>

</body>
</html>