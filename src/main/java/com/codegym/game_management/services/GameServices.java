package com.codegym.game_management.services;

import com.codegym.game_management.dao.CategoryDAO;
import com.codegym.game_management.dao.GameDAO;
import com.codegym.game_management.entity.Categories;
import com.codegym.game_management.entity.Games;
import com.google.protobuf.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class GameServices {
    private static final GameDAO GAME_DAO = new GameDAO();
    private static final CategoryDAO CATEGORY_DAO = new CategoryDAO();

    public GameServices() {

    }
    public static void renderPageGames(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Games> games = GAME_DAO.getAll();
        request.setAttribute("categoryCreateGame", games);
        request.getRequestDispatcher("/WEB-INF/view/admin/home.jsp").forward(request, response);
    }

    public static void renderFormCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Categories> categories = CATEGORY_DAO.getAllCategory();
        request.setAttribute("categoryCreateGame", categories);
        request.getRequestDispatcher("/WEB-INF/view/admin/create.jsp").forward(request, response);
    }

    public static void createGame(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Games newGame = new Games();
        newGame.setImage(request.getParameter("image"));
        newGame.setName(request.getParameter("name"));
        newGame.setDescription(request.getParameter("description"));
        newGame.setPrice(Double.parseDouble("price"));

        Categories category = new Categories();
        category.setName(request.getParameter("category"));
        newGame.setCategory(category);
        GAME_DAO.create(
                newGame.getName(),
                newGame.getImage(),
                newGame.getDescription(),
                newGame.getPrice(),
                newGame.getCategory()
        );
        request.getRequestDispatcher("/WEB-INF/view/admin/home.jsp").forward(request, response);
    }
}
