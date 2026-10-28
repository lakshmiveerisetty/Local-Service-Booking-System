package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        String bookingIdText = request.getParameter("bookingId");
        String status = request.getParameter("status");

        if (bookingIdText == null
                || !bookingIdText.matches("\\d+")
                || status == null
                || !("PENDING".equals(status)
                    || "CONFIRMED".equals(status)
                    || "COMPLETED".equals(status)
                    || "CANCELLED".equals(status))) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid booking ID or status."
            );
            return;
        }

        int bookingId = Integer.parseInt(bookingIdText);

        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, bookingId);

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("AdminDashboardServlet");
            } else {
                response.getWriter().println("Booking not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating booking status.");
        }
    }
}