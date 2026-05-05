package com.codegym.game_management.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    //private static String url = "jdbc:mysql://db:3306/game_management?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    //private static String username = "root";
    //private static String password = "root";
    private static String url = System.getenv("DB_URL");
    private static String username = System.getenv("DB_USERNAME");
    private static String password = System.getenv("DB_PASSWORD");

    public Database() {

    }

    public static Connection getConnection() {
        System.out.printf("13432432");
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
        }
        return connection;
    }
}
