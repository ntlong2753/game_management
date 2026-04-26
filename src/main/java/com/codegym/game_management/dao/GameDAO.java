package com.codegym.game_management.dao;

import com.codegym.game_management.entity.Categories;
import com.codegym.game_management.entity.Games;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GameDAO extends BaseDAO {

    public List<Games> getAll() throws SQLException {
        List<Games> list = new ArrayList<>();
        String sql = "SELECT games.*, categories.name AS category_name " +
                    "FROM games " +
                    "JOIN categories ON games.category_id = categories.id";
        PreparedStatement statement = connect.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            Games game = new Games();
            game.setId(resultSet.getInt("id"));
            game.setName(resultSet.getString("name"));
            game.setImage(resultSet.getString("image"));
            game.setDescription(resultSet.getString("description"));
            game.setPrice(resultSet.getDouble("price"));

            Categories category = new Categories();
            category.setId(resultSet.getInt("category_id"));
            category.setName(resultSet.getString("category_name"));
            game.setCategory(category);
            list.add(game);
        }
        return list;
    }

    public void create(String name, String image, String description, double price, Categories category) throws SQLException {
        String sql = "INSERT INTO games(name, image, description, price, category_id) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, image);
        statement.setString(3, description);
        statement.setDouble(4, price);
        statement.setInt(5, category.getId());
        statement.executeUpdate();
    }

    public void updateById(int id, String name, String image, String description, double price) throws SQLException {
        String sql = "DELETE FROM user WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.executeUpdate(sql);
    }

    public ResultSet getById(int id) throws SQLException {
        String sql = "SELECT * FROM user WHERE id = ?";
        Statement statement = connect.prepareStatement(sql);
        return statement.executeQuery(sql);
    }

    public ResultSet search(String keyword) throws SQLException {
        String sql = "SELECT * FROM user WHERE username LIKE '%" + keyword + "%'";
        Statement statement = connect.prepareStatement(sql);
        return statement.executeQuery(sql);
    }
}
