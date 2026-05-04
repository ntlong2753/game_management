package com.codegym.game_management.controller;

import com.codegym.game_management.services.AuthServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "authController", urlPatterns = "/game-management/*")
public class AuthServlet extends HttpServlet {
    private AuthServices authServices = new AuthServices();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            pathInfo = "/";
        }

        switch (pathInfo) {
            case "/admin/login":
                authServices.renderPageLogin(request, response);
                break;
            case"/user/login":
                authServices.renderPageUserLogin(request, response);
                break;
            case "/user/register":
                authServices.renderPageUserRegistration(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/admin/login":
                try {
                    authServices.handleAdminLogin(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case"/user/login":
                try {
                    authServices.handleUserLogin(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/user/register":
                try {
                    authServices.handleUserRegister(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
        }
    }
}
