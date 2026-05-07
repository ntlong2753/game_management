package com.codegym.game_management.services;

import com.codegym.game_management.dao.AuthDAO;
import com.codegym.game_management.entity.Admin;
import com.codegym.game_management.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class AuthServices {
    public final AuthDAO authDAO = new AuthDAO();

    public void renderPageLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String error = request.getParameter("error");
        if ("true".equals(error)) {
            request.setAttribute("errorMessage", "Invalid username or password.");
        }
        request.getRequestDispatcher("/WEB-INF/view/admin/login.jsp").forward(request, response);
    }

    public void renderPageUserLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = request.getParameter("error");
        if ("true".equals(error)) {
            request.setAttribute("errorMessage", "Invalid username or password.");
        }
        request.getRequestDispatcher("/WEB-INF/view/user/user_login.jsp").forward(request, response);
    }

    public void renderPageUserRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/user/user_register.jsp").forward(request, response);
    }

    /* ...
    public void handleAdminLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("admin".equals(username) && "admin".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("userLogged", username);
            session.setAttribute("userRole", "ADMIN");
            response.sendRedirect(request.getContextPath() + "/home-admin");
        } else {
            request.setAttribute("errorMessage", "Sai tài khoản hoặc mật khẩu Admin!");
            request.getRequestDispatcher("/WEB-INF/view/admin/login.jsp").forward(request, response);
        }
    }
    ... */

    public void handleAdminLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = authDAO.loginAdmin(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentAdmin", admin);
            session.setAttribute("adminLogged", admin.getUsername());
            session.setAttribute("adminRole", "ADMIN");

            response.sendRedirect(request.getContextPath() + "/home-admin/");
        } else {
            request.setAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/view/admin/login.jsp").forward(request, response);
        }
    }

    public void handleUserLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authDAO.loginUser(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("userLogged", user.getUsername());
            session.setAttribute("userRole", "USER");

            response.sendRedirect(request.getContextPath() + "/home-user/");
        } else {
            request.setAttribute("errorMessage", "Tài khoản hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/view/user/user_login.jsp").forward(request, response);
        }
    }

    public void handleUserRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        User newUser = new User();
        newUser.setUsername(request.getParameter("username"));
        newUser.setPhone(request.getParameter("phone"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setNameDisplay(request.getParameter("display_name"));
        newUser.setPassword(request.getParameter("password"));
        newUser.setRole("USER");

        String errorMessage = null;
        if (authDAO.isUsernameExists(username) || authDAO.isPhoneExists(phone) || authDAO.isEmailExists(email)) {
            errorMessage = "Dữ liệu không hợp lệ";
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/WEB-INF/view/user/user_register.jsp").forward(request, response);
        } else {
            authDAO.registerUser(newUser);
            response.sendRedirect(request.getContextPath() + "/game-management/user/login?status=success");
        }

        /* ...
        authDAO.registerUser(newUser);
        response.sendRedirect(request.getContextPath() + "/game-management/user/login?status=success");
        ... */
    }
}
