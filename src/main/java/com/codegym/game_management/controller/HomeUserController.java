package com.codegym.game_management.controller;

import com.codegym.game_management.dao.GameDAO;
import com.codegym.game_management.entity.Games;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "homeUser", urlPatterns = "/home-user/*")
public class HomeUserController extends HttpServlet {
    private static final GameDAO GAME_DAO = new GameDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
}
