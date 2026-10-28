
package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.utility.DBConnection;
import com.utility.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("ResetPasswordServlet is running!");
    	HttpSession session = request.getSession(false);

    	System.out.println("Session: " + session);

    	if (session != null) {
    	    System.out.println("resetUserId: "
    	            + session.getAttribute("resetUserId"));

    	    System.out.println("otpVerified: "
    	            + session.getAttribute("otpVerified"));
    	}

    	if (session == null
    	        || session.getAttribute("resetUserId") == null
    	        || !Boolean.TRUE.equals(session.getAttribute("otpVerified"))) {

    	    response.sendRedirect("ForgotPassword.jsp");
    	    return;
    	}

    	Long expiry = (Long) session.getAttribute("resetOtpExpiry");

    	System.out.println("Reset expiry value: " + expiry);
    	System.out.println("Current time: " + System.currentTimeMillis());

    	if (expiry == null || System.currentTimeMillis() > expiry) {
    	    System.out.println("Reset session expired!");

    	    session.removeAttribute("resetUserId");
    	    session.removeAttribute("otpVerified");
    	    session.removeAttribute("resetOtpExpiry");

    	    response.sendRedirect("ForgotPassword.jsp?error=expired");
    	    return;
    	}

    	System.out.println("Reset session is valid.");

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || confirmPassword == null
                || newPassword.length() < 8) {

            response.sendRedirect("ResetPassword.jsp?error=short");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("ResetPassword.jsp?error=mismatch");
            return;
        }

        int userId = ((Number) session.getAttribute("resetUserId")).intValue();

        try {
            String passwordHash = PasswordUtil.hashPassword(newPassword);

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, passwordHash);
            ps.setInt(2, userId);

            int rowsUpdated = ps.executeUpdate();

            System.out.println("Rows updated: " + rowsUpdated);

            ps.close();
            con.close();

            if (rowsUpdated > 0) {
                System.out.println("Password updated successfully!");

                session.removeAttribute("resetUserId");
                session.removeAttribute("otpVerified");
                session.removeAttribute("resetOtp");
                session.removeAttribute("demoOtp");
                session.removeAttribute("resetMethod");
                session.removeAttribute("resetOtpExpiry");

                response.sendRedirect("ResetPassword.jsp?updated=success");
            } else {
                System.out.println("Password update failed!");

                response.sendRedirect("ResetPassword.jsp?error=failed");
            }

            

            
            

        } catch (Exception e) {
            throw new ServletException("Unable to reset password.", e);
        }
    }
}