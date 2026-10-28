<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utility.DBConnection" %>
<%
if (session.getAttribute("userId") == null) {
response.sendRedirect("Login.jsp");
return;
}

String userName = (String) session.getAttribute("userName");
List<String[]> services = new ArrayList<>();
try {
    Connection con = DBConnection.getConnection();

    String sql = "SELECT service_name, description FROM services WHERE active = TRUE ORDER BY service_name";
    PreparedStatement ps = con.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        services.add(new String[] {
            rs.getString("service_name"),
            rs.getString("description")
        });
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace();
}

%>

<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Home - Local Service Booking</title><style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f4f7fc;
    color: #183b63;
}

nav {
    background: #173e68;
    color: white;
    padding: 18px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.logo {
    font-size: 22px;
    font-weight: bold;
}

nav a {
    color: white;
    text-decoration: none;
    margin-left: 18px;
    font-size: 14px;
}

nav a:hover {
    color: #93c5fd;
}

.welcome {
    padding: 48px 7%;
    background: linear-gradient(120deg, #dbeafe, #ffffff);
}

.welcome h1 {
    font-size: 32px;
    margin-bottom: 14px;
}

.welcome h1 span {
    color: #0875e1;
}

.welcome p {
    color: #475569;
    line-height: 1.8;
    font-size: 16px;
}

.services {
    padding: 38px 6%;
    text-align: center;
}

.services h2 {
    font-size: 28px;
    margin-bottom: 10px;
}

.subtitle {
    color: #64748b;
    margin-bottom: 28px;
}

.service-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    padding: 25px 18px;
    border-radius: 12px;
    box-shadow: 0 4px 14px rgba(0,0,0,0.07);
}

.emoji {
    font-size: 38px;
    margin-bottom: 14px;
}

.card h3 {
    margin-bottom: 12px;
}

.card p {
    color: #64748b;
    font-size: 14px;
    line-height: 1.6;
    min-height: 44px;
}

.card a {
    display: block;
    margin-top: 18px;
    padding: 11px;
    background: #e0edff;
    color: #075fc5;
    border-radius: 7px;
    text-decoration: none;
    font-weight: bold;
}

.card a:hover {
    background: #c7e0ff;
}

footer {
    margin-top: 25px;
    background: #173e68;
    color: white;
    text-align: center;
    padding: 20px;
}

@media (max-width: 600px) {
    nav {
        justify-content: center;
    }

    nav a {
        margin: 7px;
    }
}
</style></head><body><nav>
    <div class="logo">⌂ Local Service Booking</div>
    <div>
        <a href="Home.jsp">Home</a>
        <a href="Profile.jsp">My Profile</a>
        <a href="#services">Services</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="ChangePassword.jsp">Change Password</a>
        <a href="LogoutServlet"
   onclick="return confirm('Do you really want to logout?');">
    Logout
</a>
    </div>
</nav><section class="welcome">
    <h1>Welcome, <span><%= userName == null ? "Customer" : userName %></span>!</h1>
    <p>
        Welcome to your customer dashboard.<br>
        Choose a service below to get started with your home service booking.
    </p>
</section><section class="services" id="services">
    <h2>Available Services</h2>
    <p class="subtitle">Find the right professional for your home</p><div class="service-list">

    <%
for (String[] service : services) {
    String name = service[0];
    String description = service[1] == null ? "" : service[1];
    String emoji = "🛠️";

    if ("Plumbing".equalsIgnoreCase(name)) {
        emoji = "🔧";
    } else if ("Electrical Repair".equalsIgnoreCase(name)) {
        emoji = "💡";
    } else if ("Home Cleaning".equalsIgnoreCase(name)) {
        emoji = "🧹";
    } else if ("Carpenter".equalsIgnoreCase(name)) {
        emoji = "🪚";
    } else if ("AC Repair".equalsIgnoreCase(name)) {
        emoji = "❄️";
    }
%>
    <div class="card">
        <div class="emoji"><%= emoji %></div>
        <h3><%= name %></h3>
        <p><%= description %></p>
        <a href="BookService.jsp?service=<%= java.net.URLEncoder.encode(name, "UTF-8") %>">Book Service</a>
    </div>
<%
}
%>

</div>

</section><footer>
    © 2026 Local Service Booking System | All Rights Reserved
</footer></body>
</html>