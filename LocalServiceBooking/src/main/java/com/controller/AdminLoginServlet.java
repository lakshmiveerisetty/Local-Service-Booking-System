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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT user_id, full_name, password_hash, role "
                       + "FROM users WHERE email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()
                    && "ADMIN".equalsIgnoreCase(rs.getString("role"))
                    && PasswordUtil.checkPassword(
                            password, rs.getString("password_hash"))) {

                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("user_id"));
                session.setAttribute("userName", rs.getString("full_name"));
                session.setAttribute("userRole", "ADMIN");

                rs.close();
                ps.close();
                con.close();

                response.sendRedirect("AdminDashboardServlet");

            } else {
                rs.close();
                ps.close();
                con.close();

                response.getWriter().println(
                    "Invalid admin email or password.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Admin login error!");
        }
    }
}