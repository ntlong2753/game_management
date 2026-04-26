<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 21/04/2026
  Time: 04:49 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    // Giả lập lấy danh sách game từ request (Bạn thay đổi Model tương ứng của bạn)
    // List<Game> gameList = (List<Game>) request.getAttribute("gameList");

    // Biến test giao diện: Đổi thành true để xem trạng thái Rỗng, false để xem danh sách Game
    boolean isEmpty = false;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PLAYER PORTAL | GAME LIST</title>

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
            --user-accent: #f59e0b;
            --user-gradient: linear-gradient(135deg, #f59e0b 0%, #ea580c 100%);
            --card-glass: rgba(30, 41, 59, 0.7);
            --nav-glass: rgba(15, 23, 42, 0.8);
            --border-glass: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: var(--bg-dark);
            background-image:
                    radial-gradient(circle at 15% 50%, rgba(245, 158, 11, 0.08) 0%, transparent 40%),
                    radial-gradient(circle at 85% 30%, rgba(234, 88, 12, 0.08) 0%, transparent 40%);
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
        }

        .navbar-brand i {
            background: var(--user-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 1.8rem;
        }

        .nav-link-custom {
            color: #cbd5e1 !important;
            font-weight: 600;
            transition: all 0.3s;
        }

        .nav-link-custom:hover {
            color: var(--user-accent) !important;
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

        /* Search Bar Styling */
        .search-wrapper {
            max-width: 600px;
            margin: 0 auto 2.5rem auto;
            position: relative;
            z-index: 10;
        }

        .search-input {
            background: var(--card-glass);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-glass);
            color: #fff;
            border-radius: 15px 0 0 15px;
            padding: 12px 25px;
            height: 55px;
            transition: all 0.3s;
        }

        .search-input:focus {
            background: rgba(15, 23, 42, 0.9);
            color: #fff;
            border-color: var(--user-accent);
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
            outline: none;
        }

        .search-input::placeholder {
            color: #64748b;
        }

        .btn-search {
            background: var(--user-gradient);
            border: none;
            color: white;
            border-radius: 0 15px 15px 0;
            padding: 0 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            height: 55px;
        }

        .btn-search:hover {
            color: white;
            filter: brightness(1.1);
            box-shadow: 0 8px 20px rgba(234, 88, 12, 0.4);
        }

        /* Page Header */
        .page-header {
            margin: 3rem 0 2rem 0;
        }

        .page-title {
            font-weight: 800;
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }

        .page-title span {
            background: var(--user-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            color: #94a3b8;
            font-size: 1.1rem;
        }

        /* ====== BẢNG DANH SÁCH GAME (GLASSMORPHISM TABLE) ====== */
        .table-glass-wrapper {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            padding: 1rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            overflow-x: auto; /* Cho phép cuộn ngang trên điện thoại */
        }

        .table-custom {
            width: 100%;
            min-width: 900px; /* Đảm bảo bảng không bị bóp méo quá mức */
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 0;
        }

        .table-custom thead th {
            background: rgba(15, 23, 42, 0.6);
            color: var(--user-accent);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1rem 1.2rem;
            border-bottom: 2px solid rgba(245, 158, 11, 0.3);
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

        .table-custom tbody tr:last-child {
            border-bottom: none;
        }

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
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            transition: transform 0.3s;
        }

        .table-custom tbody tr:hover .list-game-img {
            transform: scale(1.1);
        }

        /* Text Styling */
        .col-id { font-weight: 700; color: #94a3b8; width: 60px; }
        .col-name { font-weight: 700; color: #fff; font-size: 1.05rem; }

        .badge-category {
            background: rgba(245, 158, 11, 0.15);
            color: var(--user-accent);
            border: 1px solid rgba(245, 158, 11, 0.3);
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
            color: #10b981; /* Màu xanh lá cho giá tiền */
            font-size: 1.05rem;
        }

        /* Action Button */
        .btn-action-sm {
            background: var(--user-gradient);
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-action-sm:hover {
            filter: brightness(1.1);
            box-shadow: 0 5px 15px rgba(234, 88, 12, 0.4);
            color: white;
            transform: translateY(-2px);
        }

        /* Empty State Styling */
        .empty-state {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            border: 1px dashed rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 5rem 2rem;
            text-align: center;
            margin-top: 2rem;
        }

        .empty-icon {
            font-size: 5rem;
            background: linear-gradient(135deg, #475569 0%, #1e293b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1.5rem;
            display: inline-block;
        }

        .empty-title {
            font-weight: 700;
            font-size: 1.5rem;
            color: #fff;
            margin-bottom: 1rem;
        }

        .empty-desc {
            color: #94a3b8;
            margin-bottom: 2rem;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }

        .btn-refresh {
            background: transparent;
            border: 1px solid var(--user-accent);
            color: var(--user-accent);
            border-radius: 12px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-refresh:hover {
            background: var(--user-accent);
            color: #fff;
            box-shadow: 0 5px 15px rgba(245, 158, 11, 0.3);
        }

    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="bi bi-controller"></i> GamePortal
        </a>
        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-3">
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="#">Khám Phá</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="#">Thư Viện</a>
                </li>
                <li class="nav-item">
                    <span class="text-white ms-3 me-2"><i class="bi bi-person-circle"></i> Xin chào, User!</span>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/game-management/user/login" class="btn btn-logout text-decoration-none">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="page-header text-center">
        <h1 class="page-title">Khám phá <span>Vũ Trụ Game</span></h1>
        <p class="page-subtitle">Tìm kiếm, lựa chọn và đắm chìm vào những tựa game đỉnh cao nhất</p>
    </div>

    <!-- ====== THANH TÌM KIẾM (SEARCH BAR) ====== -->
    <div class="search-wrapper">
        <form action="${pageContext.request.contextPath}/game-management/user/search" method="GET" class="d-flex">
            <input type="text" name="keyword" class="form-control search-input" placeholder="Nhập tên game cần tìm..." aria-label="Search">
            <button class="btn btn-search" type="submit">
                <i class="bi bi-search me-1"></i> Tìm
            </button>
        </form>
    </div>

    <% if (isEmpty) { // Logic kiểm tra mảng rỗng %>

    <!-- ====== TRẠNG THÁI RỖNG (EMPTY STATE) ====== -->
    <div class="empty-state">
        <i class="bi bi-ghost empty-icon"></i>
        <h3 class="empty-title">Danh sách game đang trống</h3>
        <p class="empty-desc">Hiện tại hệ thống chưa có tựa game nào được ra mắt. Vui lòng quay lại sau hoặc làm mới trang.</p>
        <a href="#" class="btn btn-refresh">
            <i class="bi bi-arrow-clockwise"></i> Làm mới
        </a>
    </div>

    <% } else { %>

    <!-- ====== TRẠNG THÁI DANH SÁCH (TABLE LIST VIEW) ====== -->
    <div class="table-glass-wrapper">
        <table class="table-custom">
            <thead>
            <tr>
                <th class="text-center">ID</th>
                <th>Hình Ảnh</th>
                <th>Tên Game</th>
                <th>Thể Loại</th>
                <th>Mô Tả</th>
                <th>Giá</th>
            </tr>
            </thead>
            <tbody>

            <!-- Bắt đầu vòng lặp JSP ở đây (VD: for(Game game : gameList) { ) -->

            <!-- Row 1 -->
            <tr>
                <td class="col-id text-center">#01</td>
                <td>
                    <!-- Bạn thay bằng URL thật từ object game.getImage() -->
                    <img src="https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Cyber Strike" class="list-game-img">
                </td>
                <td class="col-name">Cyber Strike 2077</td>
                <td><span class="badge-category">Hành Động</span></td>
                <td class="col-desc">
                    Trải nghiệm tựa game hành động nhập vai lấy bối cảnh thế giới tương lai với đồ họa đỉnh cao. Cốt truyện hấp dẫn kéo dài hàng chục giờ chơi.
                </td>
                <td class="col-price">990.000đ</td>
            </tr>

            <!-- Row 2 -->
            <tr>
                <td class="col-id text-center">#02</td>
                <td>
                    <img src="https://images.unsplash.com/photo-1614680376593-902f74cf0d41?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Age of Empires" class="list-game-img">
                </td>
                <td class="col-name">Age of Empires IV</td>
                <td><span class="badge-category">Chiến Thuật</span></td>
                <td class="col-desc">
                    Xây dựng đế chế của riêng bạn, dàn trận và chinh phục thế giới qua các thời kỳ lịch sử hào hùng cùng hàng vạn quân lính.
                </td>
                <td class="col-price">450.000đ</td>
            </tr>

            <!-- Row 3 -->
            <tr>
                <td class="col-id text-center">#03</td>
                <td>
                    <img src="https://images.unsplash.com/photo-1511512578047-dfb367046420?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="FC Online" class="list-game-img">
                </td>
                <td class="col-name">FC Online 2024</td>
                <td><span class="badge-category">Thể Thao</span></td>
                <td class="col-desc">
                    Hóa thân thành nhà quản lý tài ba, điều khiển các siêu sao bóng đá thế giới và giành lấy chiếc cúp vô địch danh giá nhất.
                </td>
                <td class="col-price">Miễn phí</td>
            </tr>

            <!-- Kết thúc vòng lặp JSP ở đây -->

            </tbody>
        </table>
    </div>

    <% } %>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>