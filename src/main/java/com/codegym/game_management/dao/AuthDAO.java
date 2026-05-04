package com.codegym.game_management.dao;

import com.codegym.game_management.model.Admin;
import com.codegym.game_management.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthDAO extends BaseDAO {
    public AuthDAO() {
        super();
    }

    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, phone, email, display_name, password, role) VALUES (?, ?, ?, ?, ?, ?)";
             PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPhone());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getNameDisplay());
            statement.setString(5, user.getPassword());
            statement.setString(6, user.getRole());

            return statement.executeUpdate() > 0;
    }

    public User loginUser(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet result = statement.executeQuery();

        if (result.next()) {
            User user = new User();
            user.setId(result.getInt("id"));
            user.setUsername(result.getString("username"));
            user.setPhone(result.getString("phone"));
            user.setEmail(result.getString("email"));
            user.setNameDisplay(result.getString("display_name"));
            user.setPassword(result.getString("password"));
            user.setRole(result.getString("role"));

            return user;
        }
        return null;
    }

    public Admin loginAdmin(String username, String password) throws SQLException {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        Connection currentConnect = getConnection();
        if (currentConnect == null) {
            throw new SQLException("Không thể kết nối đến Database. Kiểm tra cấu hình Render!");
        }

        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet result = statement.executeQuery();

        if (result.next()) {
            Admin admin = new Admin();
            admin.setId(result.getInt("id"));
            admin.setUsername(result.getString("username"));
            admin.setPassword(result.getString("password"));
            admin.setRole(result.getString("role"));

            return admin;
        }
        return null;
    }

    // Kiểm tra username đã tồn tại
    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT username FROM users WHERE username = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, username);
        ResultSet rs = statement.executeQuery();
        return rs.next();
    }

    // Kiểm tra số điện thoại đã tồn tại
    public boolean isPhoneExists(String phone) throws SQLException {
        String sql = "SELECT phone FROM users WHERE phone = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, phone);
        ResultSet rs = statement.executeQuery();
        return rs.next();

    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT email FROM users WHERE email = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, email);
        ResultSet rs = statement.executeQuery();
        return rs.next();

    }

}
