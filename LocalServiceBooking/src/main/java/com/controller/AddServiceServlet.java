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

@WebServlet("/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Called");
        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equalsIgnoreCase(
                String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceText = request.getParameter("price");
        String category = request.getParameter("category");

        try {
            double price = Double.parseDouble(priceText);

            if (serviceName == null || serviceName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || category == null || category.trim().isEmpty()
                    || !Double.isFinite(price) || price <= 0) {

                response.sendRedirect("AddService.jsp?error=invalid");
                return;
            }

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO services "
                    + "(service_name, description, price, category, active) "
                    + "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, serviceName.trim());
            ps.setString(2, description.trim());
            ps.setDouble(3, price);
            ps.setString(4, category);
            ps.setBoolean(5, true);

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("AddService.jsp?success=1");
            } else {
                response.sendRedirect("AddService.jsp?error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("AddService.jsp?error=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AddService.jsp?error=failed");
        }
    }
}