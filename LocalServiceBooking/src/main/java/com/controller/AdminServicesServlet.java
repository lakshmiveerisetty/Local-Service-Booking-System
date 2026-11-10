package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminServicesServlet")
public class AdminServicesServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
			response.sendRedirect("AdminLogin.jsp");
			return;
		}

		List<Map<String, Object>> services = new ArrayList<>();

		String sql = "SELECT service_id, service_name, description, price, emoji, active "
				+ "FROM services ORDER BY service_id DESC";

		try {
			Connection con = DBConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Map<String, Object> service = new HashMap<>();

				service.put("serviceId", rs.getInt("service_id"));
				service.put("serviceName", rs.getString("service_name"));
				service.put("description", rs.getString("description"));
				service.put("price", rs.getDouble("price"));
				service.put("emoji", rs.getString("emoji"));
				service.put("active", rs.getBoolean("active"));

				services.add(service);
			}

			rs.close();
			ps.close();
			con.close();

			request.setAttribute("services", services);

			request.getRequestDispatcher("AdminServices.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error loading services!");
		}
	}
}