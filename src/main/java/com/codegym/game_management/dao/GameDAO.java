package com.codegym.game_management.dao;

import com.codegym.game_management.entity.Categories;
import com.codegym.game_management.entity.Games;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GameDAO extends BaseDAO {

    public List<Games> getAll() throws SQLException {
        List<Games> list = new ArrayList<>();
        String sql = "SELECT games.*, categories.name AS category_name " +
                "FROM games " +
                "JOIN categories ON games.category_id = categories.id " +
                "ORDER BY games.id ASC"; // ASC là viết tắt của Ascending (tăng dần)
        PreparedStatement statement = connect.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        getList(resultSet, list);
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

    public void update(int id, String name, String image, String description, double price, Categories category)
            throws SQLException {
        String sql = "UPDATE games SET name = ?, image = ?, description = ?, price = ?, category_id = ? WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, name);
        statement.setString(2, image);
        statement.setString(3, description);
        statement.setDouble(4, price);
        statement.setInt(5, category.getId());
        statement.setInt(6, id);
        statement.executeUpdate();
    }

    public Games getById(int id) throws SQLException {
        String sql = "SELECT games.*, categories.name AS category_name " +
                    "FROM games " +
                    "JOIN categories ON games.category_id = categories.id " +
                    "WHERE games.id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();
        Games game = new Games();
        if (resultSet.next()) {
            gameList(resultSet, game);
            return game;
        }
        return null;
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM games WHERE id = ?";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setInt(1, id);
        statement.executeUpdate();
    }

    public List<Games> search(String keyword) throws SQLException {
        String sql = "SELECT games.*, categories.name AS category_name " +
                "FROM games " +
                "JOIN categories ON games.category_id = categories.id " +
                "WHERE games.name LIKE ?" +
                "ORDER BY games.id ASC";
        PreparedStatement statement = connect.prepareStatement(sql);
        statement.setString(1, "%" + keyword + "%");
        ResultSet resultSet = statement.executeQuery();
        List<Games> list = new ArrayList<>();
        getList(resultSet, list);
        return list;
    }


    private static void getList(ResultSet resultSet, List<Games> list) throws SQLException {
        while (resultSet.next()) {
            Games game = new Games();
            gameList(resultSet, game);
            list.add(game);
        }
    }

    private static void gameList(ResultSet resultSet, Games game)
            throws SQLException {
        game.setId(resultSet.getInt("id"));
        game.setName(resultSet.getString("name"));
        game.setImage(resultSet.getString("image"));
        game.setDescription(resultSet.getString("description"));
        game.setPrice(resultSet.getDouble("price"));

        Categories category = new Categories();
        category.setId(resultSet.getInt("category_id"));
        category.setName(resultSet.getString("category_name"));
        game.setCategory(category);
    }

    /* ...
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
    ... */
}
