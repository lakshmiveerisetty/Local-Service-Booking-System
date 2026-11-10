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

@WebServlet("/DeleteServiceServlet")
public class DeleteServiceServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
			response.sendRedirect("AdminLogin.jsp");
			return;
		}

		try {
			int serviceId = Integer.parseInt(request.getParameter("serviceId"));

			Connection con = DBConnection.getConnection();

			String sql = "UPDATE services SET active = FALSE " + "WHERE service_id = ?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, serviceId);

			int rows = ps.executeUpdate();

			ps.close();
			con.close();

			if (rows > 0) {
				response.sendRedirect("AdminServicesServlet");
			} else {
				response.getWriter().println("Service not found!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error deleting service!");
		}
	}
}