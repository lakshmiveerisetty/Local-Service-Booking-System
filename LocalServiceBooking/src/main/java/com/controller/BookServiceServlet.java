package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookServiceServlet")
public class BookServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String serviceName = request.getParameter("service");
        String bookingDate = request.getParameter("bookingDate");
        String bookingTime = request.getParameter("bookingTime");
        String address = request.getParameter("address");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // Find the service ID using the selected service name
            String findService = 
                "SELECT service_id FROM services WHERE service_name = ?";

            ps = con.prepareStatement(findService);
            ps.setString(1, serviceName);
            rs = ps.executeQuery();

            if (!rs.next()) {
                response.getWriter().println("Selected service not found!");
                return;
            }

            int serviceId = rs.getInt("service_id");

            rs.close();
            ps.close();
            rs = null;
            ps = null;

            // Insert the booking into the database
            String sql = "INSERT INTO bookings "
                    + "(user_id, service_id, booking_date, "
                    + "booking_time, address, status) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setDate(3, java.sql.Date.valueOf(bookingDate));
            ps.setTime(4, java.sql.Time.valueOf(bookingTime + ":00"));
            ps.setString(5, address);
            ps.setString(6, "PENDING");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("MyBookingsServlet");
            } else {
                response.getWriter().println("Booking failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error while booking service!");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}