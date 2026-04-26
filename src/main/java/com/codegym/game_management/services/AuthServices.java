package com.codegym.game_management.services;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthServices {

    public AuthServices() {

    }

    public static void renderPageLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = request.getParameter("error");
        if ("true".equals(error)) {
            request.setAttribute("errorMessage", "Invalid username or password.");
        }
        request.getRequestDispatcher("/WEB-INF/view/admin/login.jsp").forward(request, response);
    }

    public static void renderPageUserLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = request.getParameter("error");
        if ("true".equals(error)) {
            request.setAttribute("errorMessage", "Invalid username or password.");
        }
        request.getRequestDispatcher("/WEB-INF/view/user/user_login.jsp").forward(request, response);
    }

    public static void renderPageUserRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/user/user_register.jsp").forward(request, response);
    }

    public static void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");


        if ("admin".equals(role) && "admin".equals(username) && "admin".equals(password)) {
            // TẠO SESSION Ở ĐÂY
            HttpSession session = request.getSession();
            session.setAttribute("userLogged", username);
            session.setAttribute("userRole", "ADMIN");

            response.sendRedirect(request.getContextPath() + "/home-admin");
        }

        else if ("user".equals(role) && "user".equals(username) && "user".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("userLogged", username);
            session.setAttribute("userRole", "USER");

            response.sendRedirect("/home-user");
        }

        else {
            if("admin".equals(role)) {
                request.setAttribute("errorMessage", "Sai tài khoản, mật khẩu hoặc vai trò không đúng!");
                request.getRequestDispatcher("/WEB-INF/view/admin/login.jsp").forward(request, response);
            }
            if("user".equals(role)) {
                request.setAttribute("errorMessage", "Sai tài khoản, mật khẩu hoặc vai trò không đúng!");
                request.getRequestDispatcher("/WEB-INF/view/user/user_login.jsp").forward(request, response);
            }
        }
    }
}
