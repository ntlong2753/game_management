<%--
  Created by IntelliJ IDEA.
  User: ntlong
  Date: 21/04/2026
  Time: 04:48 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>USER REGISTER | PLAYER PORTAL</title>

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
      --user-accent: #f59e0b;
      --user-gradient: linear-gradient(135deg, #f59e0b 0%, #ea580c 100%);
      --card-glass: rgba(30, 41, 59, 0.8);
      --input-glass: rgba(15, 23, 42, 0.6);
      --border-glass: rgba(255, 255, 255, 0.1);
    }

    body {
      font-family: 'Be Vietnam Pro', sans-serif;
      background-color: var(--bg-dark);
      background-image:
              radial-gradient(circle at 0% 0%, rgba(245, 158, 11, 0.12) 0%, transparent 35%),
              radial-gradient(circle at 100% 100%, rgba(234, 88, 12, 0.12) 0%, transparent 35%);
      color: #f8fafc;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0;
      overflow-x: hidden;
      overflow-y: auto; /* Cho phép cuộn dọc nếu form quá dài trên đt */
      padding: 2rem 0; /* Cách đều trên dưới cho màn hình nhỏ */
    }

    .register-container {
      width: 100%;
      max-width: 480px; /* Form đăng ký nên rộng hơn 1 chút so với form login */
      padding: 20px;
      z-index: 10;
    }

    .register-card {
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

    .register-card::before {
      content: '';
      position: absolute;
      top: 0; left: 50%; transform: translateX(-50%);
      width: 120px; height: 4px;
      background: var(--user-gradient);
      border-radius: 0 0 10px 10px;
    }

    .brand-logo {
      width: 75px;
      height: 75px;
      background: var(--user-gradient);
      border-radius: 22px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2.2rem;
      margin: 0 auto 1.5rem;
      color: white;
      box-shadow: 0 10px 25px rgba(234, 88, 12, 0.3);
    }

    .register-title {
      font-weight: 700;
      font-size: 1.6rem;
      text-align: center;
      margin-bottom: 0.5rem;
      text-transform: uppercase;
      color: #fff;
    }

    .register-subtitle {
      text-align: center;
      color: #94a3b8;
      font-size: 0.95rem;
      margin-bottom: 2.5rem;
    }

    /* Form Styling - Nền kính, chữ trắng, không bị lỗi nền trắng khi focus */
    .form-floating > .form-control {
      background: var(--input-glass);
      border: 1px solid var(--border-glass);
      color: #fff;
      border-radius: 18px;
      padding-left: 1.2rem;
      height: 55px; /* Thu nhỏ chiều cao 1 xíu so với login vì form này nhiều field */
      transition: all 0.3s ease;
    }

    .form-floating > .form-control:focus {
      background: rgba(15, 23, 42, 0.8);
      border-color: var(--user-accent);
      box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
      color: #fff;
    }

    .form-floating > label {
      color: #94a3b8;
      padding-left: 1.2rem;
      padding-top: 0.85rem; /* Điều chỉnh lại label cho cân đối với height 55px */
    }

    .form-floating > .form-control:focus ~ label,
    .form-floating > .form-control:not(:placeholder-shown) ~ label {
      color: var(--user-accent);
      transform: scale(0.85) translateY(-0.7rem) translateX(0.15rem);
    }

    .form-floating > label::after {
      background-color: transparent !important;
    }

    .btn-register {
      background: var(--user-gradient);
      border: none;
      border-radius: 18px;
      padding: 15px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      margin-top: 1.5rem;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .btn-register:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 25px rgba(234, 88, 12, 0.4);
      filter: brightness(1.1);
    }

    .login-link {
      font-size: 0.95rem;
    }

    .login-link a {
      color: var(--user-accent);
      font-weight: 600;
      text-decoration: none;
      transition: all 0.3s ease;
    }

    .login-link a:hover {
      color: #fbbf24;
      text-shadow: 0 0 10px rgba(245, 158, 11, 0.5);
    }

    .back-home {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #64748b;
      text-decoration: none;
      font-size: 0.95rem;
      transition: all 0.3s;
      margin-top: 1.5rem;
    }

    .back-home:hover {
      color: var(--user-accent);
    }
  </style>
</head>
<body>

<div class="register-container">
  <div class="register-card">
    <!-- Icon Đăng ký -->
    <div class="brand-logo">
      <i class="bi bi-person-vcard-fill"></i>
    </div>

    <h2 class="register-title">Tạo Tài Khoản</h2>
    <p class="register-subtitle">Gia nhập cộng đồng người chơi ngay hôm nay</p>

    <form action="${pageContext.request.contextPath}/game-management/user/register" method="post">

      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" required autocomplete="off">
        <label for="username">Tên đăng nhập</label>
      </div>

      <div class="form-floating mb-3">
        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required autocomplete="off">
        <label for="email">Địa chỉ Email</label>
      </div>

      <div class="form-floating mb-3">
        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required autocomplete="off">
        <label for="phone">Số điện thoại</label>
      </div>

      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
        <label for="password">Mật khẩu</label>
      </div>

      <div class="form-floating mb-3">
        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Nhập lại mật khẩu" required>
        <label for="confirm_password">Xác nhận mật khẩu</label>
      </div>

      <button class="btn btn-register w-100" type="submit">
        Hoàn tất đăng ký <i class="bi bi-check2-circle ms-1 fs-5"></i>
      </button>
    </form>

    <div class="login-link text-center mt-4">
      <span class="text-muted">Đã có tài khoản? </span>
      <a href="${pageContext.request.contextPath}/game-management/user/login">Đăng nhập ngay</a>
    </div>

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
