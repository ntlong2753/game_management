<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 19/04/2026
  Time: 09:28 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");

    // Giả sử Controller truyền vào một object "game" chứa thông tin cần sửa
    // Game game = (Game) request.getAttribute("game");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN PORTAL | UPDATE GAME</title>

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
            --input-glass: rgba(15, 23, 42, 0.6);
            --border-glass: rgba(255, 255, 255, 0.1);
            /* Màu cam/vàng đặc trưng cho hành động Update (Sửa) */
            --btn-update: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
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

        .nav-link-custom:hover {
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
        }

        .page-title {
            font-weight: 800;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 0;
        }

        .page-title span {
            background: var(--btn-update);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .btn-back {
            background: transparent;
            color: #cbd5e1;
            border: 1px solid var(--border-glass);
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        /* Form Glassmorphism */
        .form-glass-wrapper {
            background: var(--card-glass);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass);
            border-radius: 25px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            max-width: 800px;
            margin: 0 auto;
            position: relative;
        }

        .badge-edit {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(245, 158, 11, 0.2);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
            padding: 5px 15px;
            border-radius: 100px;
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .form-label {
            font-weight: 600;
            color: #cbd5e1;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            background: var(--input-glass);
            border: 1px solid var(--border-glass);
            color: #fff;
            border-radius: 12px;
            padding: 12px 18px;
            transition: all 0.3s ease;
        }

        .form-select option {
            background-color: var(--bg-dark);
            color: #fff;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(15, 23, 42, 0.9);
            color: #fff;
            border-color: #f59e0b;
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
        }

        /* Tùy chỉnh input type file */
        .form-control[type="file"] {
            padding: 10px 18px;
        }

        .form-control[type="file"]::file-selector-button {
            background: var(--btn-update);
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 8px;
            margin-right: 15px;
            font-weight: 600;
            transition: all 0.3s;
            cursor: pointer;
        }

        .form-control[type="file"]::file-selector-button:hover {
            filter: brightness(1.1);
        }

        .file-hint {
            display: block;
            font-size: 0.8rem;
            color: #94a3b8;
            margin-top: 8px;
        }

        /* Nút Submit */
        .form-actions {
            margin-top: 2.5rem;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
        }

        .btn-submit {
            background: var(--btn-update);
            border: none;
            color: white;
            border-radius: 12px;
            padding: 12px 30px;
            font-weight: 700;
            font-size: 1.05rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-submit:hover {
            filter: brightness(1.1);
            box-shadow: 0 8px 20px rgba(245, 158, 11, 0.3);
            transform: translateY(-2px);
        }

        /* Alerts */
        .alert-custom {
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #fca5a5;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #6ee7b7;
        }

        @media (max-width: 768px) {
            .form-glass-wrapper {
                padding: 2rem 1.5rem;
            }
            .form-actions {
                flex-direction: column;
            }
            .btn-submit, .btn-back {
                width: 100%;
                justify-content: center;
            }
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
                    <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/home-admin">Quản Lý Game</a>
                </li>
                <li class="nav-item">
                    <span class="text-white ms-3 me-2"><i class="bi bi-person-circle"></i> Xin chào, Quản trị viên!</span>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">

    <!-- Header -->
    <div class="page-header">
        <h1 class="page-title">Cập Nhật <span>Thông Tin</span></h1>
        <a href="${pageContext.request.contextPath}/home-admin" class="btn-back">
            <i class="bi bi-arrow-left"></i> Hủy / Quay lại
        </a>
    </div>

    <!-- Form Update Game -->
    <div class="form-glass-wrapper">
        <span class="badge-edit">EDIT MODE</span>

        <% if (errorMessage != null) { %>
        <div class="alert-custom alert-error">
            <i class="bi bi-exclamation-triangle-fill"></i> <%= errorMessage %>
        </div>
        <% } %>

        <% if (successMessage != null) { %>
        <div class="alert-custom alert-success">
            <i class="bi bi-check-circle-fill"></i> <%= successMessage %>
        </div>
        <% } %>

        <!-- Form xử lý Update -->
        <form action="${pageContext.request.contextPath}/home-admin/edit" method="post" enctype="multipart/form-data">

            <!-- TRƯỜNG ẨN: Truyền ID của Game cần sửa -->
            <input type="hidden" name="id" value="${game.id}">

            <div class="row g-4">
                <!-- Tên Game -->
                <div class="col-md-6">
                    <label for="name" class="form-label">Tên Game <span class="text-danger">*</span></label>
                    <!-- Thêm thuộc tính value="${game.name}" để render lại tên cũ -->
                    <input type="text" class="form-control" id="name" name="name" value="${game.name}" placeholder="Nhập tên trò chơi..." required autocomplete="off">
                </div>

                <!-- Thể Loại -->
                <div class="col-md-6">
                    <label for="category" class="form-label">Thể Loại <span class="text-danger">*</span></label>
                    <!-- Dùng biểu thức điều kiện để selected thể loại cũ của game -->
                    <select class="form-select" id="category" name="category" required>
                        <option value="" disabled>-- Chọn thể loại --</option>
                        <option value="Hành Động" ${game.category == 'Hành Động' ? 'selected' : ''}>Hành Động</option>
                        <option value="Chiến Thuật" ${game.category == 'Chiến Thuật' ? 'selected' : ''}>Chiến Thuật</option>
                        <option value="Nhập Vai (RPG)" ${game.category == 'Nhập Vai (RPG)' ? 'selected' : ''}>Nhập Vai (RPG)</option>
                        <option value="Thể Thao" ${game.category == 'Thể Thao' ? 'selected' : ''}>Thể Thao</option>
                        <option value="Giải Đố" ${game.category == 'Giải Đố' ? 'selected' : ''}>Giải Đố</option>
                        <option value="Kinh Dị" ${game.category == 'Kinh Dị' ? 'selected' : ''}>Kinh Dị</option>
                    </select>
                </div>

                <!-- Giá Game -->
                <div class="col-md-6">
                    <label for="price" class="form-label">Giá tiền (VNĐ) <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <input type="number" class="form-control" id="price" name="price" value="${game.price}" placeholder="VD: 500000" min="0" required>
                        <span class="input-group-text bg-dark text-white border-secondary">VNĐ</span>
                    </div>
                </div>

                <!-- Hình Ảnh (Không bắt buộc) -->
                <div class="col-md-6">
                    <label for="image" class="form-label">Cập nhật Hình Ảnh</label>
                    <!-- BỎ thuộc tính required, cho phép submit mà không cần chọn ảnh mới -->
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    <span class="file-hint"><i class="bi bi-info-circle"></i> Bỏ trống nếu không muốn thay đổi hình ảnh hiện tại.</span>
                </div>

                <!-- Mô Tả -->
                <div class="col-12">
                    <label for="description" class="form-label">Mô tả chi tiết</label>
                    <!-- Textarea không có thuộc tính value, dữ liệu để vào giữa cặp thẻ -->
                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập mô tả về game...">${game.description}</textarea>
                </div>
            </div>

            <!-- Nút thao tác -->
            <div class="form-actions">
                <button type="submit" class="btn btn-submit">
                    <i class="bi bi-save2-fill"></i> Cập Nhật Thay Đổi
                </button>
            </div>

        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
