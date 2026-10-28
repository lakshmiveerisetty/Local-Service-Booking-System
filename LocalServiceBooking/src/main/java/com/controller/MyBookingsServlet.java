package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        List<Map<String, Object>> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, s.service_name, " +
                     "b.booking_date, b.booking_time, b.address, b.status " +
                     "FROM bookings b " +
                     "JOIN services s ON b.service_id = s.service_id " +
                     "WHERE b.user_id = ? " +
                     "ORDER BY b.booking_id DESC";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();

                booking.put("bookingId", rs.getInt("booking_id"));
                booking.put("serviceName", rs.getString("service_name"));
                booking.put("bookingDate", rs.getDate("booking_date"));
                booking.put("bookingTime", rs.getTime("booking_time"));
                booking.put("address", rs.getString("address"));
                booking.put("status", rs.getString("status"));

                bookings.add(booking);
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("bookings", bookings);

            request.getRequestDispatcher("MyBookings.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error loading bookings!");
        }
    }
}