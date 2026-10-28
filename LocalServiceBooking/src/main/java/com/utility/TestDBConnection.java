package com.utility;

import java.sql.Connection;

public class TestDBConnection {

    public static void main(String[] args) {

        try (Connection con = DBConnection.getConnection()) {
            System.out.println(
                "MySQL Database Connected Successfully!"
            );
        } catch (Exception e) {
            System.out.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}