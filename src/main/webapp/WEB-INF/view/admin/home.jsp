<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 19/04/2026
  Time: 09:28 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codegym.game_management.entity.Games" %>
<%
    // Giả lập lấy danh sách game từ request cho Admin
    List<Games> gameList = (List<Games>) request.getAttribute("game");

    boolean isEmpty = (gameList == null || gameList.isEmpty());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN PORTAL | DASHBOARD</title>

    <!-- Thêm icon trên tab trình duyệt -->
    <link rel="icon" href="${pageContext.request.contextPath}/image/adminGame.png" type="image/png">

    <!-- Google Fonts: Be Vietnam Pro -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --bg-dark: #0f172a;
            --admin-accent: #38bdf8;
            --admin-gradient: linear-gradient(135deg, #38bdf8 0%, #0ea5e9 100%);
            --card-glass: rgba(30, 41, 59, 0.7);
            --nav-glass: rgba(15, 23, 42, 0.8);
            --border-glass: rgba(255, 255, 255, 0.1);
            --btn-add: linear-gradient(135deg, #10b981 0%, #059669 100%);
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: var(--bg-dark);
            background-image:
                    radial-gradient(circle at 15% 50%, rgba(56, 189, 248, 0.08) 0%, transparent 40%),
                    radial-gradient(circle at 85% 30%, rgba(14, 165, 233, 0.08) 0%, transparent 40%);
            background-attachment: fixed;
            color: #f8fafc;
            min-height: 100vh;
            margin: 0;
            padding-bottom: 3rem;
        }

        /* Navbar Glassmorphism */
        .navbar-custom {
            background: var(--nav-glass);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-bottom: 1px solid var(--border-glass);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: #fff !important;
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
        }

        .navbar-brand i {
            background: var(--admin-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 1.8rem;
        }

        .nav-link-custom {
            color: #cbd5e1 !important;
            font-weight: 600;
            transition: all 0.3s;
        }

        .nav-link-custom:hover, .nav-link-custom.active {
            color: var(--admin-accent) !important;
        }

        .btn-logout {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 12px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-logout:hover {
            background: #ef4444;
            color: white;
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
        }

        /* Page Header */
        .page-header {
            margin: 3rem 0 2rem 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .page-title {
            font-weight: 800;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 0;
        }

        .page-title span {
            background: var(--admin-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Action Bar (Search & Add Button) */
        .action-bar {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-wrapper {
            position: relative;
            min-width: 350px;
        }

        .search-input {
            background: var(--card-glass);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-glass);
            color: #fff;
            border-radius: 12px 0 0 12px;
            padding: 10px 20px;
            height: 48px;
            transition: all 0.3s;
        }

        .search-input:focus {
            background: rgba(15, 23, 42, 0.9);
            color: #fff;
            border-color: var(--admin-accent);
            box-shadow: 0 0 0 4px rgba(56, 189, 248, 0.15);
            outline: none;
        }

        .search-input::placeholder {
            color: #64748b;
        }

        .btn-search {
            background: var(--admin-gradient);
            border: none;
            color: white;
            border-radius: 0 12px 12px 0;
            padding: 0 25px;
            font-weight: 600;
            transition: all 0.3s;
            height: 48px;
        }

        .btn-search:hover {
            color: white;
            filter: brightness(1.1);
            box-shadow: 0 5px 15px rgba(14, 165, 233, 0.3);
        }

        .btn-add {
            background: var(--btn-add);
            border: none;
            color: white;
            border-radius: 12px;
            padding: 0 25px;
            font-weight: 600;
            height: 48px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-add:hover {
            color: white;
            filter: brightness(1.1);
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
            transform: translateY(-2px);
        }

        /* Nút Hiển thị tất cả */
        .btn-show-all {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid var(--border-glass);
            color: #cbd5e1;
            border-radius: 12px;
            padding: 0 20px;
            font-weight: 600;
            height: 48px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-show-all:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
        }

        /* ====== BẢNG QUẢN LÝ (GLASSMORPHISM TABLE) ====== */
        .table-glass-wrapper {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            padding: 1rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            overflow-x: auto;
        }

        .table-custom {
            width: 100%;
            min-width: 900px;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 0;
        }

        .table-custom thead th {
            background: rgba(15, 23, 42, 0.6);
            color: var(--admin-accent);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1rem 1.2rem;
            border-bottom: 2px solid rgba(56, 189, 248, 0.3);
            font-size: 0.9rem;
        }

        .table-custom thead th:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
        .table-custom thead th:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; }

        .table-custom tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .table-custom tbody tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .table-custom tbody tr:last-child { border-bottom: none; }

        .table-custom td {
            padding: 1rem 1.2rem;
            vertical-align: middle;
            color: #cbd5e1;
            font-size: 0.95rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* Image Column */
        .list-game-img {
            width: 80px;
            height: 45px;
            object-fit: contain;
            /*object-fit: cover;*/
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Text Styling */
        .col-id { font-weight: 700; color: #94a3b8; width: 60px; }
        .col-name { font-weight: 700; color: #fff; font-size: 1.05rem; }

        .badge-category {
            background: rgba(56, 189, 248, 0.15);
            color: var(--admin-accent);
            border: 1px solid rgba(56, 189, 248, 0.3);
            padding: 5px 10px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .col-desc {
            min-width: 250px;
            max-width: 450px;
            color: #94a3b8;
            line-height: 1.6;
            white-space: normal; /* Cho phép chữ tự động xuống dòng */
            word-wrap: break-word; /* Ngăn các từ quá dài làm vỡ bảng */
        }

        .col-price {
            font-weight: 700;
            color: #10b981;
            font-size: 1.05rem;
        }

        /* Action Buttons (Edit & Delete) */
        .action-btns {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .btn-edit {
            background: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 0.85rem;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-edit:hover {
            background: #f59e0b;
            color: white;
            box-shadow: 0 4px 10px rgba(245, 158, 11, 0.3);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.15);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 0.85rem;
            transition: all 0.3s;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-delete:hover {
            background: #ef4444;
            color: white;
            box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3);
        }

        /* Empty State */
        .empty-state {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            border: 1px dashed rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 5rem 2rem;
            text-align: center;
        }

        .empty-icon {
            font-size: 4rem;
            color: #475569;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .empty-title {
            font-weight: 700;
            font-size: 1.5rem;
            color: #fff;
            margin-bottom: 0.5rem;
        }

        .empty-desc {
            color: #94a3b8;
        }

        @media (max-width: 768px) {
            .page-header { flex-direction: column; align-items: flex-start; }
            .search-wrapper { width: 100%; min-width: auto; }
            .btn-add { width: 100%; justify-content: center; }
            .action-bar { width: 100%; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home-admin">
            <i class="bi bi-shield-check"></i> AdminPanel
        </a>
        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-3">
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/home-admin/category">Quản Lý thể loại</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-custom active" href="${pageContext.request.contextPath}/home-admin/">Quản Lý Game</a>
                </li>
                <li class="nav-item">
                    <span class="text-white ms-3 me-2"><i class="bi bi-person-circle"></i> Xin chào, Quản trị viên!</span>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/game-management/admin/login" class="btn btn-logout text-decoration-none">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">

    <!-- Header & Action Bar -->
    <div class="page-header">
        <h1 class="page-title">Quản Lý <span>Danh Mục</span></h1>

        <div class="action-bar">
            <!-- Thanh tìm kiếm -->
            <form action="${pageContext.request.contextPath}/home-admin/search" method="GET" class="d-flex search-wrapper">
                <input type="text" name="keyword" class="form-control search-input" placeholder="Tìm kiếm game..." aria-label="Search">
                <button class="btn btn-search" type="submit">
                    <i class="bi bi-search"></i>
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/home-admin" class="btn-show-all" title="Hiển thị toàn bộ danh sách">
                <i class="bi bi-collection"></i> Tất Cả
            </a>

            <!-- Nút Thêm mới -->
            <a href="${pageContext.request.contextPath}/home-admin/create" class="btn-add">
                <i class="bi bi-plus-circle-fill"></i> Thêm Game Mới
            </a>
        </div>
    </div>

    <% if (isEmpty) { %>
    <!-- ====== TRẠNG THÁI RỖNG (EMPTY STATE) ====== -->
    <div class="empty-state">
        <i class="bi bi-folder-x empty-icon"></i>
        <h3 class="empty-title">Không tìm thấy dữ liệu</h3>
        <p class="empty-desc">Danh sách game hiện đang trống hoặc không có kết quả tìm kiếm phù hợp.</p>
    </div>
    <% } else { %>
    <!-- ====== BẢNG DỮ LIỆU (DATA TABLE) ====== -->
    <div class="table-glass-wrapper">
        <table class="table-custom">
            <thead>
            <tr>
                <th class="text-center">ID</th>
                <th>Hình Ảnh</th>
                <th>Tên Game</th>
                <th>Thể Loại</th>
                <th>Mô tả</th>
                <th>Giá</th>
                <th class="text-center">Thao Tác</th>
            </tr>
            </thead>
            <tbody>

            <% for (Games game : gameList) { %>
            <tr>
                <td class="col-id text-center"><%=game.getId()%></td>
                <td>
                    <img src="<%=request.getContextPath()%>/<%= game.getImage()%>" alt="Hình ảnh" class="list-game-img">
                </td>
                <td class="col-name"><%=game.getName()%></td>
                <td><span class="badge-category"><%=game.getCategory().getName()%></span></td>
                <td class="col-desc"><%=game.getDescription()%></td>
                <td class="col-price"><%= String.format("%,.0f", game.getPrice()) %> VNĐ</td>
                <td class="text-center">
                    <div class="action-btns">
                        <!-- Nút Sửa -->
                        <a href="/home-admin/edit?id=<%=game.getId()%>" class="btn-edit" title="Chỉnh sửa">
                            <i class="bi bi-pencil-square"></i> Sửa
                        </a>
                        <!-- Nút Xóa -->
                        <a href="/home-admin/delete?id=<%=game.getId()%>" class="btn-delete" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa game này không?');">
                            <i class="bi bi-trash3-fill"></i> Xóa
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            <!-- Kết thúc vòng lặp JSP -->

            </tbody>
        </table>
    </div>

    <% } %>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>