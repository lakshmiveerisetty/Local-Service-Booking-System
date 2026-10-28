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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            System.out.println("Database:"+con.getCatalog());
            
            String sql = "SELECT user_id, full_name, password_hash, role "
                    + "FROM users WHERE email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");

                if (PasswordUtil.checkPassword(password, rs.getString("password_hash"))) {

                    HttpSession session = request.getSession();

                    session.setAttribute("userId", rs.getInt("user_id"));
                    session.setAttribute("userName", rs.getString("full_name"));
                    String role = rs.getString("role");
                    session.setAttribute("userRole", role);

                    

                    if ("ADMIN".equalsIgnoreCase(role)) {
                        response.sendRedirect("AdminDashboardServlet");
                    } else {
                        response.sendRedirect("Home.jsp");
                    }

                } else {
                    response.sendRedirect("Login.jsp?error=invalid");
                }
            } else {
                response.getWriter().println("Invalid email or password!");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println(
                "Login failed: " + e.getMessage());
        }    }
}