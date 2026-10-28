
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map"%>

<%
if (session.getAttribute("userId") == null) {
	response.sendRedirect("Login.jsp");
	return;
}

String userName = (String) session.getAttribute("userName");

List<Map<String, Object>> bookings = (List<Map<String, Object>>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Bookings</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f4f7fb;
	margin: 0;
	padding: 25px;
}

h1 {
	color: #243b64;
	text-align: center;
}

.top {
	text-align: center;
	margin-bottom: 25px;
}

a {
	color: #2457a7;
	text-decoration: none;
	margin: 10px;
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

.empty {
	text-align: center;
	padding: 25px;
	background: white;
}

.cancel-btn {
	background: #dc3545;
	color: white;
	border: none;
	padding: 9px 12px;
	border-radius: 5px;
	cursor: pointer;
}

.cancel-btn:hover {
	background: #b02a37;
}

.cancelled {
	color: #dc3545;
	font-weight: bold;
}

.status {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 15px;
	font-weight: bold;
	font-size: 12px;
}

.status.pending {
	background: #fff3cd;
	color: #856404;
}

.status.accepted,
.status.confirmed {
    background: #d1ecf1;
    color: #0c5460;
}

.status.completed {
	background: #d4edda;
	color: #155724;
}

.status.cancelled {
	background: #f8d7da;
	color: #721c24;
}
</style>
</head>

<body>

	<h1>My Bookings</h1>

	<div class="top">
		<p>
			Welcome,
			<%=userName%>!
		</p>
		<a href="Home.jsp">Home</a> <a href="BookService.jsp">Book Another
			Service</a> <a href="LogoutServlet"
			onclick="return confirm('Do you really want to logout?');">
			Logout </a>
	</div>

	<%
	if (bookings == null || bookings.isEmpty()) {
	%>

	<div class="empty">
		<p>You have not booked any services yet.</p>
		<a href="BookService.jsp">Book a Service</a>
	</div>

	<%
	} else {
	%>

	<table>
		<tr>
			<th>Booking ID</th>
			<th>Service</th>
			<th>Date</th>
			<th>Time</th>
			<th>Address</th>
			<th>Status</th>
			<th>Action</th>
		</tr>

		<%
		for (Map<String, Object> booking : bookings) {
			String status = String.valueOf(booking.get("status"));
			boolean canCancel = !status.equalsIgnoreCase("COMPLETED") && !status.equalsIgnoreCase("CANCELLED");
		%>

		<tr>
			<td><%=bookings.indexOf(booking) + 1%></td>
			<td><%=booking.get("serviceName")%></td>
			<td><%=booking.get("bookingDate")%></td>
			<td><%=booking.get("bookingTime")%></td>
			<td><%=booking.get("address")%></td>

			<td>
    <span class="status <%= status.toLowerCase() %>">
        <%= status %>
    </span>
</td>

			<td>
				<%
				if (canCancel) {
				%>
				<form action="CancelBookingServlet" method="post"
					onsubmit="return confirm('Are you sure you want to cancel this booking?');">

					<input type="hidden" name="bookingId"
						value="<%=booking.get("bookingId")%>">

					<button type="submit" class="cancel-btn">Cancel Booking</button>
				</form> <%
 } else {
 %> Not Available <%
 }
 %>
			</td>
		</tr>

		<%
		}
		%>

	</table>

	<%
	}
	%>

</body>
</html>
