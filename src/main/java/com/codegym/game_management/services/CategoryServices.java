package com.codegym.game_management.services;

import com.codegym.game_management.dao.CategoryDAO;
import com.codegym.game_management.entity.Categories;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CategoryServices {
    public static final CategoryDAO CATEGORY_DAO = new CategoryDAO();
    public CategoryServices() {

    }

    public static void renderPageCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Categories> categories = CATEGORY_DAO.getAllCategory();
        request.setAttribute("category", categories);
        request.getRequestDispatcher("/WEB-INF/view/category/category.jsp").forward(request, response);
    }

    public static void createCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        Categories newCategory = new Categories();
        newCategory.setName(request.getParameter("name"));
        CATEGORY_DAO.createCategory(
            newCategory.getName()
        );
        response.sendRedirect(request.getContextPath() + "/home-admin/category/");
    }

    public static void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        CATEGORY_DAO.delete(Integer.parseInt(id));
        response.sendRedirect(request.getContextPath() + "/home-admin/category");
    }


    public static void editCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        CATEGORY_DAO.updateCategory(id, name);
        response.sendRedirect(request.getContextPath() + "/home-admin/category");
    }

    public static void searchCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String keyword = request.getParameter("keyword");
        List<Categories> resultSearch = CATEGORY_DAO.search(keyword);
        System.out.println(resultSearch.size());
        System.out.println(resultSearch);
        request.setAttribute("category", resultSearch);
        request.getRequestDispatcher("/WEB-INF/view/category/category.jsp").forward(request, response);
    }
}
