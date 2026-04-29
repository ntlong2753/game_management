<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GAME PORTAL EVOLUTION | PREMIUM</title>

    <!-- Thêm icon trên tab trình duyệt -->
    <link rel="icon" href="${pageContext.request.contextPath}/image/management.png" type="image/png">

    <!-- Google Fonts: Be Vietnam Pro -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;600;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --bg-dark: #070b14;
            --admin-gradient: linear-gradient(135deg, #00d2ff 0%, #3a7bd5 100%);
            --player-gradient: linear-gradient(135deg, #ff9966 0%, #ff5e62 100%);
            --card-glass: rgba(16, 23, 41, 0.4);
            --border-glass: rgba(255, 255, 255, 0.08);
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: var(--bg-dark);
            color: #f8fafc;
            /* Cố định chiều cao 100% màn hình, ẩn thanh cuộn */
            height: 100vh;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            position: relative;
        }

        /* NÂNG CẤP VIP 1: Lưới không gian (Cyber Grid) */
        .cyber-grid {
            position: absolute;
            inset: 0;
            background-image:
                    linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
            background-size: 40px 40px;
            z-index: 0;
            pointer-events: none;
        }
        .cyber-grid::after {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, transparent 10%, var(--bg-dark) 80%);
        }

        /* NÂNG CẤP VIP 2: Ánh sáng không gian (Ambient Glow) mịn hơn */
        .ambient-glow {
            position: absolute;
            width: 50vw;
            height: 50vw;
            border-radius: 50%;
            filter: blur(140px);
            z-index: 0;
            opacity: 0.15;
            animation: pulse 8s infinite alternate;
        }

        .glow-admin { background: #3a7bd5; top: -20%; left: -10%; }
        .glow-player { background: #ff5e62; bottom: -20%; right: -10%; animation-delay: -4s; }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.1; }
            100% { transform: scale(1.1); opacity: 0.2; }
        }

        /* Animation xuất hiện khi load trang */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .main-container {
            padding: 0 2rem;
            width: 100%;
            max-width: 1100px;
            z-index: 10;
            position: relative;
            animation: fadeInUp 1s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
        }

        /* Ép các khoảng cách nhỏ lại để vừa 1 trang */
        .hero-title {
            font-weight: 800;
            font-size: clamp(2rem, 5vw, 3.8rem);
            letter-spacing: -0.02em;
            text-transform: uppercase;
            line-height: 1.1;
            margin-bottom: 0.8rem;
            background: linear-gradient(180deg, #ffffff 0%, #94a3b8 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0px 8px 15px rgba(0,0,0,0.4));
        }

        .hero-subtitle {
            font-size: 1rem;
            color: #94a3b8;
            max-width: 700px;
            margin: 0 auto 2.5rem; /* Thu nhỏ margin */
            font-weight: 300;
            line-height: 1.6;
        }

        .card-wrapper {
            text-decoration: none;
            display: block;
            color: inherit;
        }

        /* Glass Card Premium - Thu nhỏ padding */
        .choice-card {
            background: var(--card-glass);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass);
            border-radius: 35px;
            padding: 2.2rem 1.8rem; /* Ép nhỏ lại */
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .choice-card::before {
            content: '';
            position: absolute;
            top: 0; left: -150%; width: 50%; height: 100%;
            background: linear-gradient(to right, transparent, rgba(255,255,255,0.06), transparent);
            transform: skewX(-25deg);
            transition: all 0.7s ease;
        }

        .card-wrapper:hover .choice-card::before { left: 150%; }

        .card-wrapper:hover .choice-card {
            transform: translateY(-10px);
            border-color: rgba(255, 255, 255, 0.25);
            background: rgba(30, 41, 59, 0.7);
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
        }

        /* Icon Box thu nhỏ lại */
        .icon-box {
            width: 75px;
            height: 75px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            margin-bottom: 1.2rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.4);
            color: white;
            transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card-wrapper:hover .icon-box { transform: scale(1.1) translateY(-3px); }

        .admin-icon { background: var(--admin-gradient); }
        .player-icon { background: var(--player-gradient); }

        .card-title {
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 0.8rem;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .card-desc {
            color: #94a3b8;
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 1.8rem;
            font-weight: 400;
            transition: color 0.3s;
        }

        .card-wrapper:hover .card-desc { color: #f1f5f9; }

        .badge-tag {
            position: absolute;
            top: 20px;
            right: 25px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 5px 12px;
            border-radius: 100px;
            font-size: 0.7rem;
            font-weight: 600;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .card-wrapper:hover .badge-tag {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
        }

        /* Nút thu nhỏ lại 1 xíu để cân đối */
        .btn-premium {
            padding: 12px 35px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
            border: none;
            color: white !important;
            width: 85%;
            text-align: center;
        }

        .btn-admin { background: var(--admin-gradient); box-shadow: 0 8px 20px rgba(0, 210, 255, 0.2); }
        .btn-player { background: var(--player-gradient); box-shadow: 0 8px 20px rgba(255, 94, 98, 0.2); }

        .card-wrapper:hover .btn-premium {
            transform: scale(1.03);
            box-shadow: 0 12px 25px rgba(255,255,255,0.15);
            filter: brightness(1.1);
        }

        /* Chỉnh Footer ghim xuống sát đáy để không đẩy nội dung */
        .footer-premium {
            position: absolute;
            bottom: 20px;
            left: 0;
            width: 100%;
            text-align: center;
            font-size: 0.75rem;
            letter-spacing: 2px;
            opacity: 0.5;
            font-weight: 600;
            color: #94a3b8;
            margin: 0;
        }

        @media (max-width: 768px) {
            body { height: auto; overflow: auto; padding: 2rem 0; }
            .hero-title { font-size: 2rem; }
            .ambient-glow, .cyber-grid { display: none; }
            .footer-premium { position: relative; margin-top: 2rem; }
        }
    </style>
</head>
<body>

<!-- NÂNG CẤP: Lưới Cyber & Hiệu ứng Glow -->
<div class="cyber-grid"></div>
<div class="ambient-glow glow-admin"></div>
<div class="ambient-glow glow-player"></div>

<div class="main-container text-center">
    <!-- Header -->
    <header>
        <h1 class="hero-title">GAME PORTAL<br>EVOLUTION</h1>
        <p class="hero-subtitle">Hệ thống quản lý trò chơi đẳng cấp thế giới. Trải nghiệm tinh tế, công nghệ đỉnh cao và quản lý thông minh vượt thời gian.</p>
    </header>

    <!-- Cards -->
    <div class="row justify-content-center g-4">
        <!-- Admin -->
        <div class="col-lg-5 col-md-6">
            <a href="${pageContext.request.contextPath}/game-management/admin/login" class="card-wrapper">
                <div class="choice-card">
                    <span class="badge-tag">System Control</span>
                    <div class="icon-box admin-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h3 class="card-title">QUẢN TRỊ VIÊN</h3>
                    <p class="card-desc">
                        Quyền hạn tối ưu trong tay bạn. Quản lý danh mục, kiểm soát người dùng và theo dõi hệ thống trong thời gian thực.
                    </p>
                    <div class="btn-premium btn-admin">Đăng nhập Admin</div>
                </div>
            </a>
        </div>

        <!-- Player -->
        <div class="col-lg-5 col-md-6">
            <a href="${pageContext.request.contextPath}/game-management/user/login" class="card-wrapper">
                <div class="choice-card">
                    <span class="badge-tag">Play Now</span>
                    <div class="icon-box player-icon">
                        <i class="bi bi-controller"></i>
                    </div>
                    <h3 class="card-title">NGƯỜI CHƠI</h3>
                    <p class="card-desc">
                        Khám phá vũ trụ game đỉnh cao. Tìm kiếm những tựa game hot nhất và tận hưởng những phút giây giải trí không giới hạn.
                    </p>
                    <div class="btn-premium btn-player">Vào hệ thống</div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Footer ghim sát đáy -->
<p class="footer-premium">CASE STUDY NGUYEN THANH LONG &copy; 2026</p>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>