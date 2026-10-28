
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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

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

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        if (fullName == null || fullName.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Name and phone number are required."
            );
            return;
        }

        fullName = fullName.trim();
        phone = phone.trim();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE users SET full_name = ?, phone = ? "
                       + "WHERE user_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, userId);

            int rowsUpdated = ps.executeUpdate();

            ps.close();
            con.close();

            if (rowsUpdated > 0) {
                session.setAttribute("userName", fullName);
                response.sendRedirect("Profile.jsp?updated=success");
            } else {
                response.sendRedirect("Profile.jsp?updated=failed");
            }

        } catch (Exception e) {
            throw new ServletException("Unable to update profile.", e);
        }
    }
}
