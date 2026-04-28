<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 21/04/2026
  Time: 04:49 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codegym.game_management.model.Games" %>
<%
    // Giả lập lấy danh sách game từ request (Bạn thay đổi Model tương ứng của bạn)
    List<Games> gameList = (List<Games>) request.getAttribute("listGamesUser");

    // Biến test giao diện: Đổi thành true để xem trạng thái Rỗng, false để xem danh sách Game
    boolean isEmpty = (gameList == null || gameList.isEmpty());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PLAYER PORTAL</title>

    <!-- Thêm icon trên tab trình duyệt -->
    <link rel="icon" href="${pageContext.request.contextPath}/image/game1.png" type="image/png">

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
            --bg-card: #1e293b;
            --user-accent: #f59e0b;
            --user-gradient: linear-gradient(135deg, #f59e0b 0%, #ea580c 100%);
            --card-glass: rgba(30, 41, 59, 0.7);
            --nav-glass: rgba(15, 23, 42, 0.85);
            --border-glass: rgba(255, 255, 255, 0.1);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: var(--bg-dark);
            background-image:
                    radial-gradient(circle at 15% 50%, rgba(245, 158, 11, 0.08) 0%, transparent 40%),
                    radial-gradient(circle at 85% 30%, rgba(234, 88, 12, 0.08) 0%, transparent 40%);
            background-attachment: fixed;
            color: var(--text-main);
            min-height: 100vh;
            margin: 0;
            padding-bottom: 4rem;
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
            text-decoration: none;
        }

        .btn-logout:hover {
            background: #ef4444;
            color: white;
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
        }

        /* Search Bar Styling */
        .search-wrapper {
            max-width: 600px;
            margin: 0 auto 3rem auto;
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
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* ====== SECTION HEADER ====== */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            margin-top: 2rem;
        }
        .section-title {
            font-size: 1.3rem;
            font-weight: 800;
            text-transform: uppercase;
            border-left: 4px solid var(--user-accent);
            padding-left: 12px;
            margin: 0;
            letter-spacing: 0.5px;
        }
        .view-all {
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: color 0.3s;
        }
        .view-all:hover { color: var(--user-accent); }

        /* ====== GAME CARD (DẠNG Ô THEO YÊU CẦU) ====== */
        .game-card-link {
            text-decoration: none;
            display: block;
            height: 100%;
        }

        .game-card {
            background: transparent;
            border: none;
            transition: transform 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .game-card-link:hover .game-card {
            transform: translateY(-5px);
        }

        /* Thumbnail Container */
        .img-container {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            aspect-ratio: 16/9;
            background-color: var(--bg-card);
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }

        .img-container img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            /*object-fit: cover;*/
            transition: transform 0.4s ease;
        }

        .game-card-link:hover .img-container img {
            transform: scale(1.08); /* Zoom nhẹ ảnh khi hover */
        }

        /* Lớp Overlay đen mờ viền dưới ảnh để chữ số giá tiền luôn rõ ràng */
        .img-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 50%;
            background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, transparent 100%);
            pointer-events: none;
        }

        /* Badge ID (Góc trên cùng bên phải) */
        .badge-id {
            position: absolute;
            top: 10px; right: 10px;
            background: rgba(0, 0, 0, 0.65);
            backdrop-filter: blur(4px);
            color: #cbd5e1;
            font-size: 0.85rem;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 8px;
            z-index: 2;
        }

        /* Badge Giá Tiền (Góc dưới cùng bên phải) */
        .badge-price {
            position: absolute;
            bottom: 10px; right: 10px;
            background: rgba(0, 0, 0, 0.75);
            backdrop-filter: blur(4px);
            color: var(--user-accent);
            font-size: 1.05rem;
            font-weight: 800;
            padding: 6px 12px;
            border-radius: 8px;
            z-index: 2;
            border: 1px solid rgba(245, 158, 11, 0.2);
            box-shadow: 0 4px 10px rgba(0,0,0,0.5);
        }

        /* Content phía dưới ảnh */
        .info-container {
            padding-top: 12px;
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* Tự động đẩy dài ra nếu mô tả nhiều chữ */
        }

        /* Thể loại */
        .tags-container {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            margin-bottom: 8px;
        }

        .tag-pill {
            background: rgba(245, 158, 11, 0.15);
            color: var(--user-accent);
            border: 1px solid rgba(245, 158, 11, 0.3);
            font-size: 0.75rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Tên Game */
        .game-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-main);
            line-height: 1.4;
            margin: 0 0 8px 0;
            transition: color 0.3s;
        }

        .game-card-link:hover .game-title {
            color: var(--user-accent);
        }

        /* Mô tả (Hiện toàn bộ, không giới hạn dòng) */
        .game-desc {
            font-size: 0.95rem;
            color: var(--text-muted);
            line-height: 1.6;
            margin: 0;
            white-space: normal;
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
            color: var(--text-muted);
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
        <a class="navbar-brand" href="/home-user/">
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
                    <a href="${pageContext.request.contextPath}/game-management/user/login" class="btn btn-logout">
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

    <!-- ====== THANH TÌM KIẾM ====== -->
    <div class="search-wrapper">
        <form action="${pageContext.request.contextPath}/home-user/search" method="GET" class="d-flex">
            <input type="text" name="keyword" class="form-control search-input" placeholder="Nhập tên game cần tìm..." aria-label="Search" autocomplete="off">
            <button class="btn btn-search" type="submit">
                <i class="bi bi-search me-1"></i> Tìm
            </button>
        </form>
    </div>

    <% if (isEmpty) { %>

    <!-- ====== TRẠNG THÁI RỖNG ====== -->
    <div class="empty-state">
        <i class="bi bi-ghost empty-icon"></i>
        <h3 class="empty-title">Danh sách game đang trống</h3>
        <p class="empty-desc">Hiện tại hệ thống chưa có tựa game nào được ra mắt. Vui lòng quay lại sau hoặc làm mới trang.</p>
        <a href="${pageContext.request.contextPath}/home-user/" class="btn btn-refresh">
            <i class="bi bi-arrow-clockwise"></i> Làm mới
        </a>
    </div>

    <% } else { %>

    <!-- ====== SECTION: KHÁM PHÁ GAME ====== -->
    <div class="section-header">
        <h2 class="section-title">Khám Phá Game</h2>
        <a href="/home-user/" class="view-all">Xem tất cả <i class="bi bi-arrow-right"></i></a>
    </div>

    <!-- ====== DANH SÁCH GAME (GRID CARDS) ====== -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">

        <!-- Bắt đầu vòng lặp JSP (for Game game : gameList) -->
        <%
            if (!isEmpty) {
                for (Games game : gameList) {
        %>
        <div class="col">
            <!-- Thẻ <a> bao trọn toàn bộ card để người dùng ấn đâu cũng vào được game -->
            <a href="#" class="game-card-link">
                <div class="game-card">

                    <!-- Khu vực Hình ảnh -->
                    <div class="img-container">
                        <!-- ID góc phải trên -->
                        <span class="badge-id"><%= game.getId() %></span>
                        <img src="<%= request.getContextPath() %>/<%= game.getImage() %>" alt="Hình ảnh">
                        <div class="img-overlay"></div>
                        <!-- Giá tiền góc phải dưới -->
                        <span class="badge-price"><%= String.format("%,.0f", game.getPrice()) %> VNĐ</span>
                    </div>

                    <!-- Khu vực Thông tin -->
                    <div class="info-container">
                        <!-- Thể loại -->
                        <div class="tags-container">
                            <span class="tag-pill"><%=game.getCategory().getName()%></span>
                        </div>
                        <!-- Tên Game -->
                        <h3 class="game-title"><%=game.getName()%></h3>
                        <!-- Mô tả hiển thị toàn bộ -->
                        <p class="game-desc"><%=game.getDescription()%></p>
                    </div>

                </div>
            </a>
        </div>
        <%
                }
            }
        %>

        <!-- Kết thúc vòng lặp JSP -->

    </div>

    <% } %>

</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>