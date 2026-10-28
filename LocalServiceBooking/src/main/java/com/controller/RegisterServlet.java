package com.controller;

import java.io.IOException;
import com.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");

		try {
			UserDAO dao = new UserDAO();

			boolean result = dao.registerUser(name, email, phone, password);

			if (result) {
				response.sendRedirect("Login.jsp");
			} else {

				response.getWriter().println("Registration Failed!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error during registration!");
		}
	}
}