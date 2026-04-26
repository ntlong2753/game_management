<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 21/04/2026
  Time: 04:18 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ADMIN LOGIN | PREMIUM ACCESS</title>

  <!-- Thêm icon trên tab trình duyệt -->
  <link rel="icon" href="${pageContext.request.contextPath}/image/adminGame.png" type="image/png">

  <!-- Google Fonts: Be Vietnam Pro -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;600;700&display=swap" rel="stylesheet">

  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

  <style>
    :root {
      --bg-dark: #0f172a;
      --admin-accent: #38bdf8;
      --admin-gradient: linear-gradient(135deg, #38bdf8 0%, #0ea5e9 100%);
      --card-glass: rgba(30, 41, 59, 0.8);
      --input-glass: rgba(15, 23, 42, 0.6);
      --border-glass: rgba(255, 255, 255, 0.1);
    }

    body {
      font-family: 'Be Vietnam Pro', sans-serif;
      background-color: var(--bg-dark);
      background-image:
              radial-gradient(circle at 0% 0%, rgba(56, 189, 248, 0.15) 0%, transparent 35%),
              radial-gradient(circle at 100% 100%, rgba(99, 102, 241, 0.15) 0%, transparent 35%);
      color: #f8fafc;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
      overflow: hidden;
    }

    .login-container {
      width: 100%;
      max-width: 550px;
      padding: 20px;
      z-index: 10;
    }

    .login-card {
      background: var(--card-glass);
      backdrop-filter: blur(25px);
      -webkit-backdrop-filter: blur(25px);
      border: 1px solid var(--border-glass);
      border-radius: 35px;
      padding: 3.5rem 2.5rem;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
      position: relative;
      animation: fadeInScale 0.6s ease-out;
    }

    @keyframes fadeInScale {
      from { opacity: 0; transform: scale(0.95); }
      to { opacity: 1; transform: scale(1); }
    }

    .login-card::before {
      content: '';
      position: absolute;
      top: 0; left: 50%; transform: translateX(-50%);
      width: 120px; height: 4px;
      background: var(--admin-gradient);
      border-radius: 0 0 10px 10px;
    }

    .brand-logo {
      width: 75px;
      height: 75px;
      background: var(--admin-gradient);
      border-radius: 22px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2.2rem;
      margin: 0 auto 1.5rem;
      color: white;
      box-shadow: 0 10px 25px rgba(14, 165, 233, 0.4);
    }

    .login-title {
      font-weight: 700;
      font-size: 1.6rem;
      text-align: center;
      margin-bottom: 0.5rem;
      text-transform: uppercase;
      color: #fff;
    }

    .login-subtitle {
      text-align: center;
      color: #94a3b8;
      font-size: 0.95rem;
      margin-bottom: 2.5rem;
    }

    /* Form Styling - Nâng cấp phần Focus */
    .form-floating > .form-control {
      background: var(--input-glass);
      border: 1px solid var(--border-glass);
      color: #fff;
      border-radius: 18px;
      padding-left: 1.2rem;
      height: 60px;
      transition: all 0.3s ease;
    }

    /* Khi click vào (Focus) - Chuyển sang nền trắng mặc định để nổi bật */
    .form-floating > .form-control:focus {
      background: rgba(15, 23, 42, 0.8);
      border-color: var(--admin-accent);
      box-shadow: 0 0 0 4px rgba(56, 189, 248, 0.15);
      color: #fff;
    }

    .form-floating > label {
      color: #94a3b8;
      padding-left: 1.2rem;
    }

    .form-floating > .form-control:focus ~ label,
    .form-floating > .form-control:not(:placeholder-shown) ~ label {
      color: var(--admin-accent);
      transform: scale(0.85) translateY(-0.75rem) translateX(0.15rem);
    }

    /* Xóa bỏ nền trắng mặc định của Bootstrap 5.3 đằng sau label */
    .form-floating > label::after {
      background-color: transparent !important;
    }

    /* Button Action */
    .btn-login {
      background: var(--admin-gradient);
      border: none;
      border-radius: 18px;
      padding: 15px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      margin-top: 1rem;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .btn-login:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 25px rgba(14, 165, 233, 0.4);
      filter: brightness(1.1);
    }

    .back-home {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #64748b;
      text-decoration: none;
      font-size: 0.95rem;
      transition: all 0.3s;
      margin-top: 2rem;
    }

    .back-home:hover {
      color: var(--admin-accent);
    }

    .alert-premium {
      background: rgba(239, 68, 68, 0.15);
      border: 1px solid rgba(239, 68, 68, 0.3);
      color: #fca5a5;
      border-radius: 15px;
      font-size: 0.9rem;
      padding: 12px;
      margin-bottom: 2rem;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }
  </style>
</head>
<body>

<div class="login-container">
  <div class="login-card">
    <div class="brand-logo">
      <i class="bi bi-shield-lock-fill"></i>
    </div>

    <h2 class="login-title">Hệ Thống Admin</h2>
    <p class="login-subtitle">Nhập thông tin để tiếp tục quản trị</p>

    <form action="${pageContext.request.contextPath}/game-management/admin/login" method="post">
      <input type="hidden" name="role" value="admin">

      <% if (errorMessage != null) { %>
      <div class="alert alert-premium">
        <i class="bi bi-exclamation-circle-fill"></i> <%= errorMessage %>
      </div>
      <% } %>

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" required autocomplete="off">
        <label for="username">Tên đăng nhập</label>
      </div>

      <div class="form-floating mb-4">
        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
        <label for="password">Mật khẩu</label>
      </div>

      <button class="btn btn-login w-100" type="submit">
        Đăng nhập hệ thống <i class="bi bi-chevron-right"></i>
      </button>
    </form>

    <div class="text-center">
      <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="bi bi-arrow-left"></i> Quay lại trang chủ
      </a>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
