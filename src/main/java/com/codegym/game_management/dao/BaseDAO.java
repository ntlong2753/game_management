package com.codegym.game_management.dao;

import com.codegym.game_management.util.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDAO {
    protected static Connection connect;

    public BaseDAO() {
        // Kiểm tra nếu connect null hoặc đã bị đóng thì khởi tạo lại
        try {
            // Thay vì gọi Database.getConnection(), ông gọi luôn hàm bên dưới
            if (connect == null || connect.isClosed()) {
                connect = getConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        Connection connection = null;
        try {
            // Lấy thông tin từ biến môi trường đã cài trên Render
            String url = System.getenv("JDBC_URL");
            String user = "nTqK6wnXGFb25jp.root"; // Username của ông trên TiDB
            String pass = System.getenv("DB_PASSWORD"); // Mật khẩu TiDB

            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
