
package com.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final SecureRandom random = new SecureRandom();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String method = request.getParameter("method");

        if (email == null || email.trim().isEmpty()
                || method == null
                || !(method.equals("email") || method.equals("mobile"))) {

            response.sendRedirect("ForgotPassword.jsp?error=invalid");
            return;
        }

        email = email.trim();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT user_id, phone FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                rs.close();
                ps.close();
                con.close();

                response.sendRedirect("ForgotPassword.jsp?error=notfound");
                return;
            }

            int userId = rs.getInt("user_id");
            String phone = rs.getString("phone");

            rs.close();
            ps.close();
            con.close();

            if (method.equals("mobile")
                    && (phone == null || phone.trim().isEmpty())) {
                response.sendRedirect("ForgotPassword.jsp?error=nophone");
                return;
            }

            int otpNumber = 100000 + random.nextInt(900000);
            String otp = String.valueOf(otpNumber);

            HttpSession session = request.getSession();
            session.setAttribute("resetUserId", userId);
            session.setAttribute("resetOtp", otp);
            session.setAttribute("resetMethod", method);
            session.setAttribute("resetOtpExpiry",
                    System.currentTimeMillis() + 5 * 60 * 1000L);

            // Demo only: show the OTP on the next page.
            // No email or SMS is actually sent.
            session.setAttribute("demoOtp", otp);

            response.sendRedirect("VerifyOTP.jsp");

        } catch (Exception e) {
            throw new ServletException("Unable to start password recovery.", e);
        }
    }
}