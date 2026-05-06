<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 22/04/2026
  Time: 10:00 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codegym.game_management.entity.Categories" %>
<%@ page import="jdk.jfr.Category" %>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");

    // Giả lập danh sách Category truyền vào từ Controller
    List<Categories> categoryList = (List<Categories>) request.getAttribute("category");

    boolean isEmpty = (categoryList == null || categoryList.isEmpty());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN PORTAL | CATEGORY MANAGEMENT</title>

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
            --input-glass: rgba(15, 23, 42, 0.6);
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

        .navbar-brand { font-weight: 800; font-size: 1.5rem; color: #fff !important; display: flex; align-items: center; gap: 10px; text-transform: uppercase; }
        .navbar-brand i { background: var(--admin-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link-custom { color: #cbd5e1 !important; font-weight: 600; transition: all 0.3s; }
        .nav-link-custom:hover, .nav-link-custom.active { color: var(--admin-accent) !important; }

        .btn-logout {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 12px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-logout:hover { background: #ef4444; color: white; box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3); }

        /* Page Header */
        .page-header { margin: 3rem 0 2rem 0; }
        .page-title { font-weight: 800; font-size: 2.2rem; text-transform: uppercase; letter-spacing: 1px; margin: 0; }
        .page-title span { background: var(--admin-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }

        /* Split Panels (Chia cột Trái - Phải) */
        .glass-panel {
            background: var(--card-glass);
            backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            height: 100%;
        }

        .panel-title { font-weight: 700; color: #fff; margin-bottom: 1.5rem; font-size: 1.3rem; display: flex; align-items: center; gap: 10px; }

        /* Form Styling */
        .form-label { font-weight: 600; color: #cbd5e1; font-size: 0.95rem; }
        .form-control { background: var(--input-glass); border: 1px solid var(--border-glass); color: #fff; border-radius: 12px; padding: 12px 18px; transition: all 0.3s; }
        .form-control:focus { background: rgba(15, 23, 42, 0.9); border-color: var(--admin-accent); box-shadow: 0 0 0 4px rgba(56, 189, 248, 0.15); color: #fff; }

        .btn-submit { background: var(--btn-add); border: none; color: white; border-radius: 12px; padding: 12px 20px; font-weight: 700; width: 100%; transition: all 0.3s; }
        .btn-submit:hover { filter: brightness(1.1); transform: translateY(-2px); box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3); }

        /* Table Styling */
        .table-custom { width: 100%; border-collapse: separate; border-spacing: 0; margin-bottom: 0; }
        .table-custom thead th { background: rgba(15, 23, 42, 0.6); color: var(--admin-accent); font-weight: 700; text-transform: uppercase; padding: 1rem; border-bottom: 2px solid rgba(56, 189, 248, 0.3); font-size: 0.9rem; }
        .table-custom thead th:first-child { border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
        .table-custom thead th:last-child { border-top-right-radius: 12px; border-bottom-right-radius: 12px; }
        .table-custom tbody tr { transition: all 0.3s ease; }
        .table-custom tbody tr:hover { background: rgba(255, 255, 255, 0.05); }
        .table-custom td { padding: 1rem; vertical-align: middle; color: #cbd5e1; font-size: 0.95rem; border-bottom: 1px solid rgba(255, 255, 255, 0.05); }

        .col-id { font-weight: 700; color: #94a3b8; width: 80px; }
        .col-name { font-weight: 700; color: #fff; font-size: 1.05rem; }

        /* Action Buttons */
        .btn-edit { color: #f59e0b; background: rgba(245, 158, 11, 0.15); padding: 6px 12px; border-radius: 8px; text-decoration: none; transition: 0.3s; font-size: 0.85rem;}
        .btn-edit:hover { background: #f59e0b; color: white; box-shadow: 0 4px 10px rgba(245, 158, 11, 0.3); }

        .btn-delete { color: #ef4444; background: rgba(239, 68, 68, 0.15); padding: 6px 12px; border-radius: 8px; text-decoration: none; transition: 0.3s; font-size: 0.85rem; border: none; cursor: pointer;}
        .btn-delete:hover { background: #ef4444; color: white; box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3); }

        /* Alerts */
        .alert-custom { border-radius: 12px; padding: 12px; margin-bottom: 1.5rem; font-weight: 500; display: flex; align-items: center; gap: 8px; }
        .alert-error { background: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.3); color: #fca5a5; }
        .alert-success { background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.3); color: #6ee7b7; }

        .table-responsive { overflow-x: auto; }

        .search-input-sm {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border-glass);
            color: #fff;
            border-radius: 10px 0 0 10px;
            padding: 8px 15px;
            height: 40px;
            width: 220px;
            transition: all 0.3s;
        }
        .search-input-sm:focus {
            background: rgba(15, 23, 42, 0.9);
            color: #fff;
            border-color: var(--admin-accent);
            box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.15);
            outline: none;
        }
        .search-input-sm::placeholder {
            color: #64748b;
        }
        .btn-search-sm {
            background: var(--admin-gradient);
            border: none;
            color: white;
            border-radius: 0 10px 10px 0;
            padding: 0 15px;
            height: 40px;
            transition: all 0.3s;
        }
        .btn-search-sm:hover {
            filter: brightness(1.1);
            color: white;
        }

        /* Modal Glassmorphism */
        .glass-modal {
            background: rgba(30, 41, 59, 0.95);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            color: #fff;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }
        .glass-modal .modal-header {
            border-bottom: 1px solid var(--border-glass);
        }
        .glass-modal .modal-footer {
            border-top: 1px solid var(--border-glass);
        }
        .btn-close-white {
            filter: invert(1) grayscale(100%) brightness(200%);
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
                    <a class="nav-link nav-link-custom active" href="${pageContext.request.contextPath}/home-admin/category">Quản Lý Thể Loại</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-custom" href="${pageContext.request.contextPath}/home-admin">Quản Lý Game</a>
                </li>
                <%--<li class="nav-item">
                    <a class="nav-link nav-link-custom" href="#">Người Dùng</a>
                </li>--%>
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
    <div class="page-header">
        <h1 class="page-title">Quản Lý <span>Thể Loại</span></h1>
    </div>

    <!-- Thông báo lỗi / thành công -->
    <% if (errorMessage != null) { %>
    <div class="alert-custom alert-error"><i class="bi bi-exclamation-triangle-fill"></i> <%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
    <div class="alert-custom alert-success"><i class="bi bi-check-circle-fill"></i> <%= successMessage %></div>
    <% } %>

    <div class="row g-4">
        <!-- CỘT TRÁI: FORM THÊM MỚI (ADD) -->
        <div class="col-lg-4">
            <div class="glass-panel">
                <form action="${pageContext.request.contextPath}/home-admin/category/create" method="post">
                    <!-- Chỉ giữ lại nhập Tên Thể Loại -->
                    <div class="mb-4">
                        <label for="name" class="form-label">Tên Thể Loại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="VD: Nhập Vai (RPG)..." required autocomplete="off">
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="bi bi-plus-circle-fill"></i> Thêm Vào Hệ Thống
                    </button>
                </form>
            </div>
        </div>

        <!-- CỘT PHẢI: BẢNG DANH SÁCH & XÓA (READ & DELETE) -->
        <div class="col-lg-8">
            <div class="glass-panel table-responsive">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
                    <h3 class="panel-title mb-0"><i class="bi bi-list-ul" style="color: var(--admin-accent)"></i> Danh Sách Thể Loại</h3>

                    <!-- Thanh tìm kiếm nhỏ -->
                    <form action="${pageContext.request.contextPath}/home-admin/category/search" method="GET" class="d-flex">
                        <input type="text" name="keyword" class="form-control search-input-sm" placeholder="Tìm thể loại..." autocomplete="off">
                        <button class="btn btn-search-sm" type="submit" title="Tìm kiếm">
                            <i class="bi bi-search"></i>
                        </button>
                        <!-- Nút tải lại danh sách (Hủy tìm kiếm) -->
                        <a href="${pageContext.request.contextPath}/home-admin/category" class="btn btn-search-sm ms-2 rounded text-decoration-none d-flex justify-content-center align-items-center" style="background: rgba(255,255,255,0.1); width: 40px;" title="Tải lại danh sách">
                            <i class="bi bi-arrow-clockwise"></i>
                        </a>
                    </form>
                </div>

                <% if (isEmpty) { %>
                <div class="text-center py-5">
                    <i class="bi bi-folder-x fs-1 text-secondary mb-3 d-block"></i>
                    <p class="text-secondary">Chưa có thể loại nào trong hệ thống.</p>
                </div>
                <% } else { %>
                <table class="table-custom">
                    <thead>
                    <tr>
                        <th class="text-center">ID</th>
                        <th>Tên Thể Loại</th>
                        <th class="text-center">Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(Categories category : categoryList) { %>
                    <tr>
                        <td class="col-id text-center"><%=category.getId()%></td>
                        <td class="col-name"><%=category.getName()%></td>
                        <td class="text-center">
                            <div class="d-flex gap-2 justify-content-center">
                                <!-- Gọi Modal Bootstrap -->
                                <button type="button" class="btn-edit border-0" title="Sửa"
                                        data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                                        data-id="<%=category.getId()%>"
                                        data-name="<%=category.getName()%>">
                                    <i class="bi bi-pencil-square"></i>
                                </button>

                                <a href="/home-admin/category/delete?id=<%=category.getId()%>" class="btn-delete" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa thể loại này?');"><i class="bi bi-trash3-fill"></i></a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    <!-- Kết thúc lặp JSP -->
                    </tbody>
                </table>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- ====== CỬA SỔ MODAL (POPUP) SỬA THỂ LOẠI ====== -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content glass-modal">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="editCategoryModalLabel">
                    <i class="bi bi-pencil-square" style="color: var(--admin-accent)"></i> Cập Nhật Thể Loại
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="${pageContext.request.contextPath}/home-admin/category/edit" method="post">
                <div class="modal-body px-4 pt-4">
                    <!-- Trường ẩn lưu trữ ID của thể loại cần sửa -->
                    <input type="hidden" name="id" id="edit-category-id">

                    <div class="mb-3">
                        <label for="edit-category-name" class="form-label">Tên Thể Loại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="edit-category-name" name="name" required autocomplete="off">
                    </div>
                </div>

                <div class="modal-footer border-0 px-4 pb-4">
                    <button type="button" class="btn btn-secondary border-0" style="background: rgba(255,255,255,0.1);" data-bs-dismiss="modal">Hủy bỏ</button>
                    <button type="submit" class="btn-submit w-auto px-4 m-0"><i class="bi bi-save2-fill"></i> Lưu Thay Đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const editModal = document.getElementById('editCategoryModal');

    editModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;

        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');

        document.getElementById('edit-category-id').value = id;
        document.getElementById('edit-category-name').value = name;
    });
</script>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
