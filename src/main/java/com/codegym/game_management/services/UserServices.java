package com.codegym.game_management.services;

import com.codegym.game_management.dao.GameDAO;
import com.codegym.game_management.entity.Categories;
import com.codegym.game_management.entity.Games;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserServices {
    private static final GameDAO GAME_DAO = new GameDAO();

    public UserServices() {
    }

    public static void renderPageUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Gọi DAO lấy danh sách game
        List<Games> list = null;
        try {
            list = GAME_DAO.getAll();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        // 2. Đẩy danh sách ra attribute (đặt tên phải khớp với bên JSP)
        request.setAttribute("listGamesUser", list);
        // 3. Forward sang trang index/home của khách
        request.getRequestDispatcher("/WEB-INF/view/user/home_user.jsp").forward(request, response);
    }

    public static void searchGameUser (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<Games> result = new ArrayList<>();
        ResultSet resultSet = GAME_DAO.search(keyword);
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
            result.add(game);
        }
        System.out.println(result);
        request.setAttribute("listGamesUser", result);
        request.getRequestDispatcher("/WEB-INF/view/user/home_user.jsp").forward(request, response);
    }
}
