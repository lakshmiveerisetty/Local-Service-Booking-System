<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.utility.DBConnection" %>

<%
    List<String[]> serviceList = new ArrayList<>();

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();

        String sql = "SELECT DISTINCT service_name, description, emoji "
                   + "FROM services WHERE active = TRUE ORDER BY service_name";

        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            String[] service = new String[3];

            service[0] = rs.getString("service_name");
            service[1] = rs.getString("description");
            service[2] = rs.getString("emoji");

            serviceList.add(service);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<!DOCTYPE html><html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Local Service Booking System</title><style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #1e293b;
}

nav {
    background: #123b67;
    color: white;
    padding: 18px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.logo {
    font-size: 23px;
    font-weight: bold;
}

nav a {
    color: white;
    text-decoration: none;
    margin-left: 22px;
    font-size: 15px;
}

nav a:hover {
    color: #fbbf24;
}

.hero {
    text-align: center;
    padding: 75px 20px;
    background: linear-gradient(135deg, #e0f2fe, #eff6ff);
}

.hero h1 {
    font-size: 38px;
    color: #123b67;
    margin-bottom: 18px;
}

.hero p {
    font-size: 17px;
    color: #475569;
    margin-bottom: 28px;
    line-height: 1.7;
}

.btn {
    display: inline-block;
    padding: 12px 25px;
    margin: 6px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: bold;
}

.primary {
    background: #2563eb;
    color: white;
}

.secondary {
    background: white;
    color: #123b67;
    border: 1px solid #123b67;
}

.btn:hover {
    opacity: 0.85;
}

.services {
    padding: 45px 7%;
    text-align: center;
}

.services h2 {
    color: #123b67;
    font-size: 29px;
    margin-bottom: 12px;
}

.subtitle {
    color: #64748b;
    margin-bottom: 30px;
}

.service-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    padding: 28px 18px;
    border-radius: 10px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
    transition: transform 0.2s;
}

.card:hover {
    transform: translateY(-5px);
}

.card .emoji {
    font-size: 38px;
    margin-bottom: 15px;
}

.card h3 {
    color: #123b67;
    margin-bottom: 10px;
}

.card p {
    color: #64748b;
    font-size: 14px;
    line-height: 1.5;
}

footer {
    background: #123b67;
    color: white;
    text-align: center;
    padding: 20px;
    margin-top: 25px;
}

@media (max-width: 600px) {
    nav {
        justify-content: center;
        text-align: center;
    }

    nav a {
        margin: 6px;
    }

    .hero h1 {
        font-size: 29px;
    }
}
</style></head><body><nav>
    <div class="logo">Local Service Booking</div><div>
    <a href="Index.jsp">Home</a>
    <a href="#services">Services</a>
    <a href="Login.jsp">Login</a>
    <a href="Register.jsp">Register</a>
</div>

</nav><section class="hero">
    <h1>Your Home, Our Responsibility!</h1><p>
    Find trusted professionals for all your home service needs.<br>
    Easy booking, reliable service, and convenient solutions.
</p>

<a href="Login.jsp" class="btn primary">Book a Service</a>
<a href="Register.jsp" class="btn secondary">Create Account</a>

</section><section class="services" id="services">
    <h2>Our Services</h2>
    <p class="subtitle">
        Professional help for your everyday needs
    </p><div class="service-container">

   <div class="service-container">

    <%
        for (String[] service : serviceList) {
    %>

        <div class="card">

            <div class="emoji"><%= service[2] %></div>

            <h3><%= service[0] %></h3>

            <p>
                <%= service[1] != null && !service[1].trim().isEmpty()
                    ? service[1]
                    : "Professional service for your everyday needs." %>
            </p>

        </div>

    <%
        }
    %>

</div>

</div>

</section><footer>
    <p>© 2026 Local Service Booking System | All Rights Reserved</p>
</footer></body>
</html>