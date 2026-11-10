<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List, java.util.Map" %>

<%
    if (session.getAttribute("userId") == null
            || !"ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    List<Map<String, Object>> services =
        (List<Map<String, Object>>) request.getAttribute("services");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Services</title>

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
    padding: 12px;
    text-align: left;
}

th {
    background: #243b64;
    color: white;
}

tr:nth-child(even) {
    background: #f1f5fa;
}

button {
    background: #dc3545;
    color: white;
    border: none;
    padding: 8px 14px;
    border-radius: 5px;
    cursor: pointer;
}

button:disabled {
    background: gray;
    cursor: not-allowed;
}

.status-active {
    color: green;
    font-weight: bold;
}

.status-inactive {
    color: red;
    font-weight: bold;
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
    <h1>Manage Services</h1>
    <p>Admin Service Management</p>
</header>

<nav>
    <a href="AdminDashboardServlet">Back to Dashboard</a>
    <a href="AddService.jsp">Add New Service</a>
</nav>

<h2>All Services</h2>

<% if (services == null || services.isEmpty()) { %>

    <div class="empty">
        <p>No services available.</p>
    </div>

<% } else { %>

<table>
    <tr>
        <th>ID</th>
        <th>Emoji</th>
        <th>Service Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <% for (Map<String, Object> service : services) { %>

    <tr>
        <td><%= service.get("serviceId") %></td>
        <td><%= service.get("emoji") %></td>
        <td><%= service.get("serviceName") %></td>
        <td><%= service.get("description") %></td>
        <td>₹<%= service.get("price") %></td>

        <td>
            <% if (Boolean.TRUE.equals(service.get("active"))) { %>
                <span class="status-active">Active</span>
            <% } else { %>
                <span class="status-inactive">Inactive</span>
            <% } %>
        </td>

        <td>
            <% if (Boolean.TRUE.equals(service.get("active"))) { %>

                <form action="DeleteServiceServlet" method="post"
                      onsubmit="return confirm('Are you sure you want to delete this service?');">

                    <input type="hidden" name="serviceId"
                           value="<%= service.get("serviceId") %>">

                    <button type="submit">Delete</button>
                </form>

            <% } else { %>
                Already Deleted
            <% } %>
        </td>
    </tr>

    <% } %>
</table>

<% } %>

</body>
</html>