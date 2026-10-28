<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>

<%
if (session.getAttribute("userId") == null
        || !"ADMIN".equals(session.getAttribute("userRole"))) {
    response.sendRedirect("AdminLogin.jsp");
    return;
}

String adminName = (String) session.getAttribute("userName");

List<Map<String, Object>> bookings =
    (List<Map<String, Object>>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f2f6fc;
    margin: 0;
    padding: 20px;
}
header {
    background: #243b64;
    color: white;
    padding: 20px;
    text-align: center;
}
nav {
    text-align: center;
    margin: 20px;
}
nav a {
    display: inline-block;
    background: #243b64;
    color: white;
    text-decoration: none;
    padding: 10px 18px;
    margin: 5px;
    border-radius: 5px;
}
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    margin-top: 20px;
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}
th {
    background: #243b64;
    color: white;
}
tr:nth-child(even) {
    background: #f1f5fa;
}
.empty {
    background: white;
    padding: 25px;
    text-align: center;
}
</style>
</head>

<body>

<header>
    <h1>Admin Dashboard</h1>
    <p>Welcome, <%= adminName %>!</p>
</header>

<nav>
    <a href="AdminDashboardServlet">Refresh Bookings</a>
    <a href="AddService.jsp">Add New Service</a>
    <a href="LogoutServlet"
       onclick="return confirm('Do you really want to logout?');">
       Logout
    </a>
</nav>

<h2>All Customer Bookings</h2>

<% if (bookings == null || bookings.isEmpty()) { %>

    <div class="empty">
        <p>No bookings available.</p>
    </div>

<% } else { %>

<table>
    <tr>
        <th>ID</th>
        <th>Customer</th>
        <th>Email</th>
        <th>Service</th>
        <th>Date</th>
        <th>Time</th>
        <th>Address</th>
        <th>Status</th>
        <th>Update Status</th>
    </tr>

    <% for (Map<String, Object> booking : bookings) { %>
    <tr>
        <td><%= booking.get("bookingId") %></td>
        <td><%= booking.get("customerName") %></td>
        <td><%= booking.get("email") %></td>
        <td><%= booking.get("serviceName") %></td>
        <td><%= booking.get("bookingDate") %></td>
        <td><%= booking.get("bookingTime") %></td>
        <td><%= booking.get("address") %></td>
       <td><%= booking.get("status") %></td>

<td>
    <form action="UpdateBookingStatusServlet" method="post">

        <input type="hidden" name="bookingId"
               value="<%= booking.get("bookingId") %>">

        <select name="status" required>
            <option value="PENDING"
                <%= "PENDING".equals(booking.get("status")) ? "selected" : "" %>>
                PENDING
            </option>

            <option value="CONFIRMED"
                <%= "CONFIRMED".equals(booking.get("status")) ? "selected" : "" %>>
                CONFIRMED
            </option>

            <option value="COMPLETED"
                <%= "COMPLETED".equals(booking.get("status")) ? "selected" : "" %>>
                COMPLETED
            </option>

            <option value="CANCELLED"
                <%= "CANCELLED".equals(booking.get("status")) ? "selected" : "" %>>
                CANCELLED
            </option>
        </select>

        <button type="submit">Update</button>

    </form>
</td>
    </tr>
    <% } %>
</table>

<% } %>

</body>
</html>