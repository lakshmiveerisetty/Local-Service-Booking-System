
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

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        try {
            int bookingId = Integer.parseInt(
                request.getParameter("bookingId")
            );

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE bookings SET status = 'CANCELLED' "
                       + "WHERE booking_id = ? AND user_id = ? "
                       + "AND UPPER(status) NOT IN ('COMPLETED', 'CANCELLED')";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            int rowsUpdated = ps.executeUpdate();

            ps.close();
            con.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("MyBookingsServlet");
            } else {
                response.sendRedirect("MyBookingsServlet");
            }

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid booking ID."
            );
        } catch (Exception e) {
            throw new ServletException("Unable to cancel booking.", e);
        }
    }
}
