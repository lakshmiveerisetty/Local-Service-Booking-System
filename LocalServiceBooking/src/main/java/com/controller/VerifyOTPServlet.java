
package com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("resetUserId") == null
                || session.getAttribute("resetOtp") == null) {

            response.sendRedirect("ForgotPassword.jsp");
            return;
        }

        String enteredOtp = request.getParameter("otp");
        String storedOtp = (String) session.getAttribute("resetOtp");

        Long expiry = (Long) session.getAttribute("resetOtpExpiry");

        if (expiry == null || System.currentTimeMillis() > expiry) {
            session.removeAttribute("resetUserId");
            session.removeAttribute("resetOtp");
            session.removeAttribute("demoOtp");
            session.removeAttribute("resetMethod");
            session.removeAttribute("resetOtpExpiry");

            response.sendRedirect("ForgotPassword.jsp?error=expired");
            return;
        }

        if (enteredOtp == null || !enteredOtp.equals(storedOtp)) {
            response.sendRedirect("VerifyOTP.jsp?error=invalid");
            return;
        }

        // OTP verified. Allow the customer to open the reset page.
        session.setAttribute("otpVerified", true);

     // OTP must not be reused.
     session.removeAttribute("resetOtp");
     session.removeAttribute("demoOtp");

     // Give the user 5 minutes to reset the password.
     session.setAttribute(
         "resetOtpExpiry",
         System.currentTimeMillis() + 5 * 60 * 1000L
     );

     response.sendRedirect("ResetPassword.jsp");
    }
}