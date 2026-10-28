
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.utility.DBConnection" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("Login.jsp");
    return;
}

int userId = ((Number) session.getAttribute("userId")).intValue();

String fullName = "";
String email = "";
String phone = "";

try {
    Connection con = DBConnection.getConnection();

    String sql = "SELECT full_name, email, phone FROM users WHERE user_id = ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        fullName = rs.getString("full_name");
        email = rs.getString("email");
        phone = rs.getString("phone");
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>

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

        .profile-box {
            width: 100%;
            max-width: 450px;
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

        input[readonly] {
            background: #eeeeee;
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

    <h1>My Profile</h1>
    
    <%
String updated = request.getParameter("updated");

if ("success".equals(updated)) {
%>
    <p style="text-align:center; color:green;">
        Profile updated successfully!
    </p>
<%
} else if ("failed".equals(updated)) {
%>
    <p style="text-align:center; color:red;">
        Profile update failed. Please try again.
    </p>
<%
}
%>

    <div class="profile-box">

        <form action="UpdateProfileServlet" method="post">

            <label>Full Name</label>
            <input type="text" name="fullName"
                   value="<%= fullName == null ? "" : fullName %>"
                   maxlength="100" required>

            <label>Email</label>
            <input type="email"
                   value="<%= email == null ? "" : email %>"
                   readonly>

            <label>Phone Number</label>
            <input type="tel" name="phone"
                   value="<%= phone == null ? "" : phone %>"
                   maxlength="15" required>

            <button type="submit">Update Profile</button>

        </form>

    </div>

    <div class="top">
        <a href="Home.jsp">Home</a>
        <a href="MyBookingsServlet">My Bookings</a>
    </div>

</body>
</html>
