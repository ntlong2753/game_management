package com.codegym.game_management.controller;

import com.codegym.game_management.services.GameServices;
import com.google.protobuf.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@MultipartConfig(
        fileSizeThreshold = 0,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
@WebServlet(name = "homeAdmin", urlPatterns = "/home-admin/*")
public class HomeAdminController extends HttpServlet {
    private static GameServices gameServices = new GameServices();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/":
                try {
                    gameServices.renderPageGames(request, response);
                } catch (ServiceException e) {
                    throw new RuntimeException(e);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/create":
                request.getRequestDispatcher("/WEB-INF/view/admin/create.jsp").forward(request, response);
                break;
            case "/edit":
                request.getRequestDispatcher("/WEB-INF/view/admin/edit.jsp").forward(request, response);
                break;

        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/create":
                request.getRequestDispatcher("/WEB-INF/view/admin/create.jsp").forward(request, response);
                break;
            case "/edit":
                request.getRequestDispatcher("/WEB-INF/view/admin/edit.jsp").forward(request, response);
                break;
        }
    }
}
