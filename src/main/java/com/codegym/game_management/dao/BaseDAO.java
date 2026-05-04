package com.codegym.game_management.dao;

import com.codegym.game_management.util.Database;

import java.sql.Connection;
import java.sql.SQLException;

public class BaseDAO {
    protected static Connection connect;

    public BaseDAO() {
        // Kiểm tra nếu connect null hoặc đã bị đóng thì khởi tạo lại
        try {
            if (connect == null || connect.isClosed()) {
                connect = Database.getConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
