package com.codegym.game_management.services;

import com.codegym.game_management.dao.CategoryDAO;
import com.codegym.game_management.dao.GameDAO;
import com.codegym.game_management.entity.Categories;
import com.codegym.game_management.entity.Games;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.List;

import static jdk.jpackage.internal.IOUtils.getFileName;

public class GameServices {
    private static final GameDAO GAME_DAO = new GameDAO();
    private static final CategoryDAO CATEGORY_DAO = new CategoryDAO();

    public GameServices() {

    }
    public static void renderPageGames(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Games> games = GAME_DAO.getAll();
        request.setAttribute("game", games);
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


        // 1. Lấy Part từ input name="image"
        Part filePart = request.getPart("image");

        // 2. Lấy tên file gốc
        String fileName = filePart.getSubmittedFileName();

        // 3. Đường dẫn tuyệt đối đến thư mục images trong project của bạn
        // QUAN TRỌNG: Bạn phải copy đường dẫn thực tế từ ổ đĩa máy bạn dán vào đây
        String uploadPath = "D:/Du_lieu/CodeGym/Module_3/game_management/src/main/webapp/image_save";
        // 4. Ghi file vào thư mục project
        filePart.write(uploadPath + File.separator + fileName);
        // 5. Lưu đường dẫn này vào Database (để khi reset server vẫn còn đường dẫn để load)
        newGame.setImage("image_save/" + fileName);


        newGame.setName(request.getParameter("name"));
        newGame.setDescription(request.getParameter("description"));
        newGame.setPrice(Double.parseDouble(request.getParameter("price")));

        int categoryId = Integer.parseInt(request.getParameter("category"));
        Categories category = new Categories();
        category.setId(categoryId);
        newGame.setCategory(category);
        GAME_DAO.create(
                newGame.getName(),
                newGame.getImage(),
                newGame.getDescription(),
                newGame.getPrice(),
                newGame.getCategory()
        );
        response.sendRedirect(request.getContextPath() + "/home-admin");
    }
}
