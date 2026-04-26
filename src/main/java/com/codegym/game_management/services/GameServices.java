package com.codegym.game_management.services;

import com.codegym.game_management.dao.GameDAO;
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

    public GameServices() {

    }
    public static void renderPageGames(HttpServletRequest request, HttpServletResponse response)
            throws ServiceException, IOException, SQLException, ServletException {
        List<Games> games = GAME_DAO.getAll();
        request.setAttribute("game", games);
        request.getRequestDispatcher("/WEB-INF/view/admin/home.jsp").forward(request, response);
    }
}
