package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.utility.DBConnection;
import com.utility.PasswordUtil;

public class UserDAO {

    public boolean registerUser(
            String name,
            String email,
            String phone,
            String password) throws Exception {

        String sql = "INSERT INTO users "
                + "(full_name, email, phone, password_hash) "
                + "VALUES (?, ?, ?, ?)";

        String passwordHash =
                PasswordUtil.hashPassword(password);

        Connection con = DBConnection.getConnection();

        try {
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, passwordHash);

            int rows = ps.executeUpdate();

            ps.close();

            return rows == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;

        } finally {
            if (con != null) {
                con.close();
            }
        }
    }
}