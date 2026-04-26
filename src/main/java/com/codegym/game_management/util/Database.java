package com.codegym.game_management.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    private static String url = "jdbc:mysql://localhost:3306/game_management?useSSL=false&serverTimezone=UTC";
    private static String username = "root";
    private static String password = "ditmemay2507@lol";
    //private String driver = "com.mysql.cj.jdbc.Driver";

    public Database() {

    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
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
