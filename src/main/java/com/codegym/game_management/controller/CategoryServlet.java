package com.codegym.game_management.controller;

import com.codegym.game_management.services.CategoryServices;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "categoryController", urlPatterns = "/home-admin/category/*")
public class CategoryServlet extends HttpServlet {
    private static final CategoryServices categoryServices = new CategoryServices();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/":
                try {
                    categoryServices.renderPageCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/delete":
                try {
                    categoryServices.deleteCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/search":
                try {
                    categoryServices.searchCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        switch (pathInfo) {
            case "/":
                try {
                    categoryServices.renderPageCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/create":
                try {
                    categoryServices.createCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/edit":
                try {
                    categoryServices.editCategory(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
        }
    }
}
