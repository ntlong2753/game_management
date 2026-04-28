package com.codegym.game_management.services;

import com.codegym.game_management.dao.CategoryDAO;
import com.codegym.game_management.dao.GameDAO;
import com.codegym.game_management.model.Categories;
import com.codegym.game_management.model.Games;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public static void renderFormUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Categories> categories = CATEGORY_DAO.getAllCategory();
        int id = Integer.parseInt(request.getParameter("id"));
        Games gameEdit = GAME_DAO.getById(id);
        if (gameEdit != null) {
            request.setAttribute("gameEdit", gameEdit);
            request.setAttribute("categoryUpdateGame", categories);
            request.getRequestDispatcher("/WEB-INF/view/admin/edit.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy game, báo lỗi hoặc về trang chủ
            response.sendRedirect(request.getContextPath() + "/home-admin?error=notfound");
        }
    }

    public static void updateGame(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
        String id = request.getParameter("id");

        String oldImage = request.getParameter("oldImage"); // Lấy lại đường dẫn cũ
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String finalImagePath;

        if (fileName != null && !fileName.isEmpty()) {
            // TRƯỜNG HỢP 1: Người dùng có chọn ảnh mới
            // Làm sạch tên file như bạn muốn (Paths.get...)
            String safeFileName = Paths.get(fileName).getFileName().toString();
            String uploadPath = "D:/Du_lieu/CodeGym/Module_3/game_management/src/main/webapp/image_save";

            filePart.write(uploadPath + File.separator + safeFileName);
            finalImagePath = "image_save/" + safeFileName;

            // (Tùy chọn) Xóa file ảnh cũ trên ổ đĩa để dọn rác
            File oldFile = new File("D:/Du_lieu/.../webapp/" + oldImage);
            if(oldFile.exists()) oldFile.delete();

        } else {
            // TRƯỜNG HỢP 2: Người dùng không chọn ảnh, giữ nguyên ảnh cũ
            finalImagePath = oldImage;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category"));
        Categories category = new Categories();
        category.setId(categoryId);
        GAME_DAO.update(Integer.parseInt(id), name, finalImagePath, description, price, category);
        response.sendRedirect(request.getContextPath() + "/home-admin");
    }

    public static void deleteGame(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        GAME_DAO.delete(Integer.parseInt(id));
        response.sendRedirect(request.getContextPath() + "/home-admin");
    }

    public static void searchGame(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        List<Games> result = new ArrayList<>();
        ResultSet resultSet = GAME_DAO.search(keyword);
        while (resultSet.next()) {
            Games game = new Games();
            game.setId(resultSet.getInt("id"));
            game.setName(resultSet.getString("name"));
            game.setImage(resultSet.getString("image"));
            game.setDescription(resultSet.getString("description"));
            game.setPrice(resultSet.getDouble("price"));

            Categories category = new Categories();
            category.setId(resultSet.getInt("category_id"));
            category.setName(resultSet.getString("category_name"));
            game.setCategory(category);
            result.add(game);
        }
        System.out.println(result);
        request.setAttribute("game", result);
        request.getRequestDispatcher("/WEB-INF/view/admin/home.jsp").forward(request, response);
    }
}
