package com.codegym.game_management.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    private static final String URL = System.getenv("DB_URL");
    private static final String USERNAME = System.getenv("DB_USERNAME");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    public Database() {

    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Connected to database successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found!");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
            return null;
        }
        return connection;
    }
}
