
package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.utility.DBConnection;
import com.utility.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {

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

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null
                || confirmPassword == null
                || currentPassword.isEmpty()
                || newPassword.isEmpty()
                || confirmPassword.isEmpty()) {

            response.sendRedirect("ChangePassword.jsp?error=empty");
            return;
        }

        if (newPassword.length() < 8) {
            response.sendRedirect("ChangePassword.jsp?error=short");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("ChangePassword.jsp?error=mismatch");
            return;
        }

        if (currentPassword.equals(newPassword)) {
            response.sendRedirect("ChangePassword.jsp?error=same");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT password_hash FROM users WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                rs.close();
                ps.close();
                con.close();

                response.sendRedirect("ChangePassword.jsp?error=failed");
                return;
            }

            String storedHash = rs.getString("password_hash");

            rs.close();
            ps.close();

            boolean passwordCorrect =
                    PasswordUtil.checkPassword(currentPassword, storedHash);

            if (!passwordCorrect) {
                con.close();
                response.sendRedirect("ChangePassword.jsp?error=incorrect");
                return;
            }

            String newPasswordHash = PasswordUtil.hashPassword(newPassword);

            String updateSql =
                    "UPDATE users SET password_hash = ? WHERE user_id = ?";

            PreparedStatement updatePs = con.prepareStatement(updateSql);
            updatePs.setString(1, newPasswordHash);
            updatePs.setInt(2, userId);

            int rowsUpdated = updatePs.executeUpdate();

            updatePs.close();
            con.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("ChangePassword.jsp?updated=success");
            } else {
                response.sendRedirect("ChangePassword.jsp?error=failed");
            }

        } catch (Exception e) {
            throw new ServletException("Unable to change password.", e);
        }
    }
}