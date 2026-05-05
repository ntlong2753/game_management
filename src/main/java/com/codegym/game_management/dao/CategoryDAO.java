package com.codegym.game_management.dao;

import com.codegym.game_management.model.Categories;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends BaseDAO {

    public List<Categories> getAllCategory() throws SQLException {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY id ASC";
        PreparedStatement statement = connect.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            Categories category = new Categories();
            category.setId(resultSet.getInt("id"));
            category.setName(resultSet.getString("name"));
            list.add(category);
        }
        return list;
    }

    public Categories getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            Categories category = new Categories();
            category.setId(resultSet.getInt("id"));
            category.setName(resultSet.getString("name"));
            return category;
        }
        return null;
    }

    public void createCategory(String name) throws SQLException {
        String sql = "INSERT INTO categories (name) VALUES (?)";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, name);
        statement.executeUpdate();
    }

    public void updateCategory(int id, String name) throws SQLException {
        String sql = "UPDATE categories SET name = ? WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, name);
        statement.setInt(2, id);
        statement.executeUpdate();
    }

    public Categories getById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setInt(1, id);
        try (ResultSet resultSet = statement.executeQuery()) {
            if (resultSet.next()) {
                Categories category = new Categories();
                category.setId(resultSet.getInt("id"));
                category.setName(resultSet.getString("name"));
                return category;
            }
        }

        return null; // Trả về null nếu không tìm thấy ID
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setInt(1, id);
        statement.executeUpdate();
    }

    public List<Categories> search(String keyword) throws SQLException {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE name LIKE ? ORDER BY id ASC";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, "%" + keyword + "%");
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            Categories category = new Categories();
            category.setId(resultSet.getInt("id"));
            category.setName(resultSet.getString("name"));
            list.add(category);
        }
        return list;
    }
}

