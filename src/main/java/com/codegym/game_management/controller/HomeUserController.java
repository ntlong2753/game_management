package com.codegym.game_management.controller;

import com.codegym.game_management.services.UserServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "homeUser", urlPatterns = "/home-user/*")
public class HomeUserController extends HttpServlet {
    private static final UserServices userServices = new UserServices();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/":
                userServices.renderPageUser(request, response);
                break;
            case "/search":
                try {
                    userServices.searchGameUser(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
        }

    }
}
