<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
                integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
                crossorigin="anonymous" referrerpolicy="no-referrer" />
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Space+Grotesk:wght@500;700&display=swap" />

            <title>School System Management - Dashboard</title>
            <style>
                :root {
                    --primary: #0e7490;
                    --primary-strong: #155e75;
                    --secondary: #f59e0b;
                    --accent: #0ea5e9;
                    --success: #15803d;
                    --warning: #b45309;
                    --danger: #b91c1c;
                    --surface: #ffffff;
                    --surface-soft: #f4f8fb;
                    --ink-900: #0f172a;
                    --ink-700: #1e293b;
                    --ink-500: #64748b;
                    --border: #d7e2ec;
                    --ring: rgba(14, 116, 144, 0.18);
                    --shadow-soft: 0 22px 48px rgba(15, 23, 42, 0.14);
                    --shadow-card: 0 12px 30px rgba(15, 23, 42, 0.1);
                    --radius-lg: 18px;
                    --radius-md: 12px;
                    --radius-sm: 9px;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'DM Sans', 'Segoe UI', sans-serif;
                    color: var(--ink-700);
                    min-height: 100vh;
                    line-height: 1.45;
                    background:
                        radial-gradient(circle at 18% 14%, rgba(14, 116, 144, 0.14) 0%, transparent 44%),
                        radial-gradient(circle at 82% 12%, rgba(245, 158, 11, 0.14) 0%, transparent 45%),
                        linear-gradient(150deg, #f3f8fb 0%, #fdf7ed 45%, #eef6ff 100%);
                }

                body::before,
                body::after {
                    content: "";
                    position: fixed;
                    border-radius: 999px;
                    pointer-events: none;
                    z-index: -1;
                    filter: blur(2px);
                }

                body::before {
                    width: 320px;
                    height: 320px;
                    bottom: -120px;
                    left: -90px;
                    background: rgba(14, 116, 144, 0.16);
                }

                body::after {
                    width: 280px;
                    height: 280px;
                    top: -100px;
                    right: -90px;
                    background: rgba(245, 158, 11, 0.14);
                }

                .dashboard {
                    display: flex;
                    min-height: 100vh;
                }

                .sidebar {
                    width: 270px;
                    background: linear-gradient(180deg, rgba(255, 255, 255, 0.98), rgba(244, 248, 251, 0.95));
                    border-right: 1px solid rgba(215, 226, 236, 0.9);
                    position: fixed;
                    height: 100vh;
                    overflow-y: auto;
                    backdrop-filter: blur(6px);
                    box-shadow: 8px 0 28px rgba(15, 23, 42, 0.08);
                }

                .sidebar::-webkit-scrollbar {
                    width: 8px;
                }

                .sidebar::-webkit-scrollbar-thumb {
                    background: rgba(14, 116, 144, 0.28);
                    border-radius: 999px;
                }

                .main-content {
                    flex: 1;
                    margin-left: 270px;
                    padding: 30px 28px;
                }

                .logo {
                    padding: 26px 20px 22px;
                    border-bottom: 1px solid var(--border);
                    text-align: center;
                }

                .logo h1 {
                    font-family: 'Space Grotesk', sans-serif;
                    font-size: 1.35rem;
                    letter-spacing: 0.03em;
                    color: var(--ink-900);
                    text-shadow: 0 1px 0 rgba(255, 255, 255, 0.8);
                }

                .logo p {
                    margin-top: 4px;
                    font-size: 0.74rem;
                    color: var(--ink-500);
                    letter-spacing: 0.12em;
                    text-transform: uppercase;
                }

                .user-info {
                    margin: 14px 14px 0;
                    padding: 18px 14px;
                    border: 1px solid var(--border);
                    border-radius: var(--radius-md);
                    background: linear-gradient(145deg, #ffffff, #f4f8fb);
                    text-align: center;
                }

                .user-avatar {
                    width: 56px;
                    height: 56px;
                    background: linear-gradient(135deg, var(--primary), var(--secondary));
                    color: white;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.25rem;
                    font-weight: 700;
                    margin-bottom: 12px;
                    box-shadow: 0 8px 18px rgba(14, 116, 144, 0.3);
                }

                .user-name {
                    font-family: 'Space Grotesk', sans-serif;
                    font-weight: 700;
                    color: var(--ink-900);
                }

                .user-type {
                    color: var(--ink-500);
                    font-size: 0.85rem;
                    letter-spacing: 0.02em;
                    margin-top: 3px;
                }

                .nav-menu {
                    padding: 18px 14px;
                }

                .nav-item {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    padding: 12px 14px;
                    color: var(--ink-700);
                    text-decoration: none;
                    border-radius: 11px;
                    margin-bottom: 7px;
                    border: 1px solid transparent;
                    transition: transform 0.22s ease, background 0.22s ease, box-shadow 0.22s ease, color 0.22s ease;
                }

                .nav-item:hover {
                    background: rgba(14, 116, 144, 0.1);
                    color: var(--primary-strong);
                    border-color: rgba(14, 116, 144, 0.2);
                    transform: translateX(3px);
                }

                .nav-item.active {
                    background: linear-gradient(135deg, var(--primary), var(--accent));
                    color: white;
                    border-color: rgba(0, 0, 0, 0.02);
                    box-shadow: 0 10px 22px rgba(14, 116, 144, 0.35);
                }

                .nav-item:focus-visible {
                    outline: none;
                    box-shadow: 0 0 0 3px var(--ring);
                }

                .nav-icon {
                    width: 20px;
                    text-align: center;
                }

                .logout-btn {
                    display: block;
                    width: calc(100% - 28px);
                    margin: 6px 14px 24px;
                    padding: 11px;
                    background: linear-gradient(135deg, var(--danger), #ea580c);
                    color: white;
                    border: none;
                    border-radius: 11px;
                    cursor: pointer;
                    text-align: center;
                    text-decoration: none;
                    font-weight: 600;
                    transition: transform 0.18s ease, box-shadow 0.18s ease, filter 0.18s ease;
                }

                .logout-btn:hover {
                    filter: brightness(1.03);
                    transform: translateY(-1px);
                    box-shadow: 0 10px 20px rgba(220, 38, 38, 0.28);
                }

                .content-section {
                    background: rgba(255, 255, 255, 0.92);
                    border: 1px solid rgba(215, 226, 236, 0.9);
                    border-radius: var(--radius-lg);
                    padding: 22px;
                    margin-bottom: 24px;
                    box-shadow: var(--shadow-soft);
                    position: relative;
                    overflow: hidden;
                }

                .content-section::before {
                    content: "";
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 4px;
                    background: linear-gradient(90deg, var(--primary), var(--secondary));
                }

                .section-title {
                    font-family: 'Space Grotesk', sans-serif;
                    color: var(--ink-900);
                    margin-bottom: 22px;
                    padding-bottom: 10px;
                    border-bottom: 1px solid var(--border);
                    position: relative;
                }

                .section-title::after {
                    content: "";
                    position: absolute;
                    left: 0;
                    bottom: -1px;
                    width: 86px;
                    height: 3px;
                    border-radius: 999px;
                    background: linear-gradient(90deg, var(--primary), var(--secondary));
                }

                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
                    gap: 18px;
                    margin-bottom: 30px;
                }

                .stat-card {
                    background: linear-gradient(165deg, #ffffff, #f4f8fb);
                    border: 1px solid rgba(215, 226, 236, 0.9);
                    padding: 22px 18px;
                    border-radius: var(--radius-md);
                    box-shadow: var(--shadow-card);
                    text-align: center;
                    transition: transform 0.22s ease, box-shadow 0.22s ease;
                }

                .stat-card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 14px 28px rgba(16, 42, 67, 0.13);
                }

                .stat-number {
                    font-family: 'Space Grotesk', sans-serif;
                    font-size: 2.2rem;
                    font-weight: 700;
                    color: var(--primary);
                    margin: 8px 0;
                }

                .stat-label {
                    color: var(--ink-500);
                    font-size: 0.85rem;
                    letter-spacing: 0.04em;
                    text-transform: uppercase;
                }

                .form-group {
                    margin-bottom: 16px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 7px;
                    color: var(--ink-700);
                    font-weight: 500;
                    font-size: 0.9rem;
                }

                .form-group input,
                .form-group select {
                    width: 100%;
                    padding: 10px 12px;
                    border: 1px solid var(--border);
                    background: var(--surface-soft);
                    border-radius: var(--radius-sm);
                    font-size: 0.92rem;
                    color: var(--ink-700);
                    transition: border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
                }

                .form-group input:hover,
                .form-group select:hover {
                    background: #fff;
                }

                .form-group input:focus,
                .form-group select:focus {
                    outline: none;
                    border-color: var(--primary);
                    box-shadow: 0 0 0 3px var(--ring);
                    background: #fff;
                }

                .btn {
                    padding: 10px 18px;
                    border: none;
                    border-radius: 10px;
                    cursor: pointer;
                    font-family: inherit;
                    font-weight: 600;
                    letter-spacing: 0.01em;
                    transition: transform 0.18s ease, box-shadow 0.18s ease, filter 0.18s ease;
                }

                .btn-primary {
                    background: linear-gradient(135deg, var(--primary), var(--accent));
                    color: white;
                }

                .btn-primary:hover {
                    filter: brightness(1.03);
                    transform: translateY(-1px);
                    box-shadow: 0 10px 20px rgba(14, 116, 144, 0.28);
                }

                .btn:focus-visible {
                    outline: none;
                    box-shadow: 0 0 0 3px var(--ring);
                }

                .btn-success {
                    background: linear-gradient(135deg, var(--success), #15803d);
                    color: white;
                }

                .btn-success:hover {
                    filter: brightness(1.03);
                    transform: translateY(-1px);
                    box-shadow: 0 10px 20px rgba(22, 163, 74, 0.3);
                }

                .table-container {
                    overflow-x: auto;
                    border: 1px solid var(--border);
                    border-radius: 12px;
                    background: #fff;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    background: #fff;
                }

                th {
                    background: linear-gradient(180deg, #f7fbff, #eef4fb);
                    padding: 13px 12px;
                    text-align: left;
                    font-weight: 600;
                    color: var(--ink-900);
                    border-bottom: 1px solid var(--border);
                    font-size: 0.8rem;
                    letter-spacing: 0.04em;
                    text-transform: uppercase;
                }

                td {
                    padding: 12px;
                    border-bottom: 1px solid var(--border);
                    color: var(--ink-700);
                    vertical-align: middle;
                }

                tr:hover {
                    background: #eef6fb;
                }

                .table-container input[type="text"],
                .table-container input[type="email"],
                .table-container input[type="date"],
                .table-container input[type="number"],
                .table-container input[type="password"],
                .table-container select {
                    width: 100%;
                    min-width: 120px;
                    padding: 8px 9px;
                    border: 1px solid rgba(215, 226, 236, 0.95);
                    border-radius: 8px;
                    background: #f8fbff;
                    color: var(--ink-700);
                    transition: border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
                }

                .table-container input:focus,
                .table-container select:focus {
                    outline: none;
                    border-color: var(--primary);
                    box-shadow: 0 0 0 2px var(--ring);
                    background: #fff;
                }

                .table-row-dirty {
                    background: linear-gradient(90deg, rgba(14, 116, 144, 0.08), rgba(245, 158, 11, 0.08));
                }

                .table-row-dirty td:first-child {
                    box-shadow: inset 4px 0 0 var(--secondary);
                }

                .btn.is-loading {
                    opacity: 0.82;
                    cursor: wait;
                    pointer-events: none;
                    transform: none;
                }

                .btn.is-loading::after {
                    content: " ...";
                }

                .grade-badge {
                    display: inline-block;
                    padding: 5px 10px;
                    border-radius: 999px;
                    font-size: 0.78rem;
                    font-weight: 600;
                }

                .grade-excellent {
                    background: #dcfce7;
                    color: #166534;
                }

                .grade-good {
                    background: #ffedd5;
                    color: #9a3412;
                }

                .grade-average {
                    background: #fef3c7;
                    color: #92400e;
                }

                .grade-poor {
                    background: #fee2e2;
                    color: #991b1b;
                }

                .action-buttons {
                    display: flex;
                    gap: 5px;
                    align-items: center;
                }

                .action-btn {
                    padding: 6px 11px;
                    border: none;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 0.76rem;
                    transition: transform 0.16s ease, filter 0.16s ease;
                }

                .action-btn.edit {
                    background: #0284c7;
                    color: white;
                }

                .action-btn.delete {
                    background: var(--danger);
                    color: white;
                }

                .action-btn:hover {
                    filter: brightness(1.04);
                    transform: translateY(-1px);
                }

                .tabs {
                    display: flex;
                    border-bottom: 1px solid var(--border);
                    margin-bottom: 20px;
                    gap: 7px;
                    flex-wrap: wrap;
                }

                .tab {
                    padding: 9px 16px;
                    cursor: pointer;
                    border-radius: 999px;
                    border: 1px solid transparent;
                    transition: all 0.22s ease;
                }

                .tab.active {
                    border-color: rgba(14, 116, 144, 0.25);
                    background: rgba(14, 116, 144, 0.11);
                    color: var(--primary-strong);
                    font-weight: 600;
                }

                .tab-content {
                    display: none;
                    animation: contentIn 0.35s ease;
                }

                .tab-content.active {
                    display: block;
                }

                .average-display {
                    text-align: center;
                    padding: 24px 20px;
                    background: linear-gradient(140deg, var(--primary), var(--accent) 58%, var(--secondary));
                    color: white;
                    border-radius: 14px;
                    margin: 20px 0;
                    box-shadow: 0 15px 28px rgba(14, 116, 144, 0.3);
                }

                .average-value {
                    font-family: 'Space Grotesk', sans-serif;
                    font-size: 3rem;
                    font-weight: 700;
                    margin: 8px 0;
                }

                .mention {
                    font-size: 1rem;
                    margin-bottom: 8px;
                    letter-spacing: 0.03em;
                    text-transform: uppercase;
                }

                .content-section h3 {
                    color: var(--ink-900);
                    font-family: 'Space Grotesk', sans-serif;
                    margin-bottom: 12px;
                }

                .content-section p {
                    color: var(--ink-700);
                }

                .text-uppercase {
                    text-transform: uppercase;
                }

                .text-secondary {
                    color: var(--ink-500);
                }

                .text-xxs {
                    font-size: 0.72rem;
                }

                .text-xs {
                    font-size: 0.78rem;
                }

                .text-sm {
                    font-size: 0.9rem;
                }

                .font-weight-bolder {
                    font-weight: 700;
                }

                .font-weight-bold {
                    font-weight: 700;
                }

                .opacity-7 {
                    opacity: 0.75;
                }

                .ps-2 {
                    padding-left: 0.5rem;
                }

                .mb-0 {
                    margin-bottom: 0;
                }

                .p-3 {
                    padding: 1rem;
                }

                .px-2 {
                    padding-right: 0.5rem;
                    padding-left: 0.5rem;
                }

                .py-1 {
                    padding-top: 0.25rem;
                    padding-bottom: 0.25rem;
                }

                .text-center {
                    text-align: center;
                }

                .align-middle {
                    vertical-align: middle;
                }

                .d-flex {
                    display: flex;
                }

                .flex-column {
                    flex-direction: column;
                }

                .justify-content-center {
                    justify-content: center;
                }

                @keyframes contentIn {
                    from {
                        opacity: 0;
                        transform: translateY(8px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @media (max-width: 980px) {
                    .sidebar {
                        width: 80px;
                    }

                    .main-content {
                        margin-left: 80px;
                    }

                    .user-name,
                    .user-type,
                    .nav-item span {
                        display: none;
                    }

                    .logo {
                        padding: 20px 0;
                    }

                    .logo h1 {
                        display: block;
                        font-size: 0.95rem;
                        letter-spacing: 0;
                    }

                    .logo p {
                        display: none;
                    }

                    .user-info {
                        margin: 12px 10px 0;
                        padding: 14px 8px;
                    }

                    .user-avatar {
                        margin: 0 auto;
                    }

                    .nav-menu {
                        padding: 14px 10px;
                    }

                    .nav-item {
                        justify-content: center;
                        padding: 10px;
                    }

                    .logout-btn {
                        width: calc(100% - 20px);
                        margin: 8px 10px 20px;
                        font-size: 0.85rem;
                    }
                }

                @media (max-width: 640px) {
                    .main-content {
                        margin-left: 80px;
                        padding: 16px 12px 24px;
                    }

                    .content-section {
                        padding: 16px;
                        border-radius: 14px;
                    }

                    .stats-grid {
                        grid-template-columns: 1fr;
                        gap: 12px;
                        margin-bottom: 20px;
                    }

                    .average-value {
                        font-size: 2.2rem;
                    }
                }

                .nav-icon i {
                    width: 20px;
                    text-align: center;
                    font-size: 15px;
                }
            </style>
        </head>

        <body>
            <div class="dashboard">
                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="logo">
                        <h1>School System</h1>
                        <p>Management Portal</p>
                    </div>

                    <div class="user-info">
                        <div class="user-avatar">
                            ${user.fullName.charAt(0)}
                        </div>
                        <div class="user-name">${user.fullName}</div>
                        <div class="user-type">${userType}</div>
                    </div>

                    <div class="nav-menu">
                        <a href="#dashboard" class="nav-item active" data-tab="dashboard">
                            <span class="nav-icon"><i class="fas fa-chart-line"></i></span>
                            <span>Tableau de bord</span>
                        </a>

                        <c:if test="${userType == 'ADMIN'}">
                            <a href="#teachers" class="nav-item" data-tab="teachers">
                                <span class="nav-icon"><i class="fas fa-chalkboard-teacher"></i></span>
                                <span>Professeurs</span>
                            </a>
                            <a href="#students" class="nav-item" data-tab="students">
                                <span class="nav-icon"><i class="fas fa-user-graduate"></i></span>
                                <span>Étudiants</span>
                            </a>
                            <a href="#subjects" class="nav-item" data-tab="subjects">
                                <span class="nav-icon"><i class="fas fa-book"></i></span>
                                <span>Matières</span>
                            </a>
                            <a href="#grades-admin" class="nav-item" data-tab="grades-admin">
                                <span class="nav-icon"><i class="fas fa-chart-bar"></i></span>
                                <span>Notes</span>
                            </a>
                            <a href="#courses" class="nav-item" data-tab="courses">
                                <span class="nav-icon"><i class="fas fa-chalkboard-teacher"></i></span>
                                <span>Cours</span>
                                </a>
                        </c:if>

                        <c:if test="${userType == 'TEACHER'}">
                            <a href="#grades-teacher" class="nav-item" data-tab="grades-teacher">
                                <span class="nav-icon"><i class="fas fa-chart-bar"></i></span>
                                <span>Gestion des notes</span>
                            </a>
                            <a href="#my-students" class="nav-item" data-tab="my-students">
                                <span class="nav-icon"><i class="fas fa-user-graduate"></i></span>
                                <span>Mes étudiants</span>
                            </a>
                        </c:if>

                        <c:if test="${userType == 'STUDENT'}">
                            <a href="#my-grades" class="nav-item" data-tab="my-grades">
                                <span class="nav-icon"><i class="fas fa-chart-line"></i></span>
                                <span>Mes notes</span>
                            </a>
                            <a href="#bulletin" class="nav-item" data-tab="bulletin">
                                <span class="nav-icon"><i class="fas fa-file-alt"></i></span>
                                <span>Mon bulletin</span>
                            </a>
                        </c:if>
                    </div>

                    <a href="/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i>Déconnexion</a>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Tableau de bord -->
                    <div id="dashboard" class="tab-content active">
                        <div class="content-section">
                            <h2 class="section-title">Bienvenue, ${user.fullName}!</h2>

                            <div class="stats-grid">
                                <c:if test="${userType == 'ADMIN'}">
                                    <div class="stat-card">
                                        <div class="stat-number">${teachers.size()}</div>
                                        <div class="stat-label">Professeurs</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-number">${students.size()}</div>
                                        <div class="stat-label">Étudiants</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-number">${subjects.size()}</div>
                                        <div class="stat-label">Matières</div>
                                    </div>
                                </c:if>

                                <c:if test="${userType == 'TEACHER'}">
                                    <div class="stat-card">
                                        <div class="stat-number">${teacherSubjectCount}</div>
                                        <div class="stat-label">Matières enseignées</div>
                                    </div>
                                    <div class="stat-card">
                                        <div class="stat-number">${teacherStudentCount}</div>
                                        <div class="stat-label">Étudiants</div>
                                    </div>
                                </c:if>

                                <c:if test="${userType == 'STUDENT'}">
                                    <div class="average-display">
                                        <div class="mention">Votre moyenne générale</div>
                                        <div class="average-value">
                                            <c:choose>
                                                <c:when test="${average != null}">
                                                    ${String.format("%.2f", average)}/100
                                                </c:when>
                                                <c:otherwise>
                                                    --
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="status">${status}</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Section Admin: Gestion des professeurs -->
                    <c:if test="${userType == 'ADMIN'}">
                        <div id="teachers" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Professeurs</h2>

                                <!-- Formulaire d'ajout -->
                                <div style="margin-bottom: 30px;">
                                    <h3 style="margin-bottom: 15px; color: #4a5568;">Ajouter un professeur</h3>
                                    <form action="/admin/add-teacher" method="post">
                                        <div
                                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                            <div class="form-group">
                                                <label for="teacherFullName">Nom complet</label>
                                                <input type="text" id="teacherFullName" name="fullName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="teacherEmail">Email</label>
                                                <input type="email" id="teacherEmail" name="email">
                                            </div>
                                            <div class="form-group">
                                                <label for="teacherPhone">Téléphone</label>
                                                <input type="text" id="teacherPhone" name="phone">
                                            </div>
                                            <div class="form-group">
                                                <label for="teacherPassword">Mot de passe</label>
                                                <input type="password" id="teacherPassword" name="password" required>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary" style="margin-top: 15px;">Ajouter
                                            le professeur</button>
                                    </form>
                                </div>

                                <c:if test="${not empty teacherUpdateError}">
                                    <div
                                        style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #fecaca; background: #fef2f2; color: #b91c1c;">
                                        ${teacherUpdateError}
                                    </div>
                                </c:if>
                                <c:if test="${not empty teacherUpdateSuccess}">
                                    <div
                                        style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #bbf7d0; background: #f0fdf4; color: #166534;">
                                        ${teacherUpdateSuccess}
                                    </div>
                                </c:if>

                                <!-- Liste des professeurs -->
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Code</th>
                                                <th>Nom complet</th>
                                                <th>Email</th>
                                                <th>Téléphone</th>
                                                <th>Date d'inscription</th>
                                                <th>Password</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="teacher" items="${teachers}">
                                                <tr>
                                                    <td>${teacher.teacherCode}</td>
                                                    <td>
                                                        <input type="text" name="fullName"
                                                            value="${teacher.fullName}" required
                                                            form="teacherUpdateForm${teacher.id}">
                                                    </td>
                                                    <td>
                                                        <input type="email" name="email"
                                                            value="${teacher.email}"
                                                            form="teacherUpdateForm${teacher.id}">
                                                    </td>
                                                    <td>
                                                        <input type="text" name="phone"
                                                            value="${teacher.phone}"
                                                            form="teacherUpdateForm${teacher.id}">
                                                    </td>
                                                    <td><c:out value="${teacher.createdAt}" default="-" /></td>
                                                    <td>
                                                        <input type="text" name="password"
                                                            value="${teacher.password}" required
                                                            form="teacherUpdateForm${teacher.id}">
                                                    </td>
                                                    <td>
                                                        <form id="teacherUpdateForm${teacher.id}"
                                                            action="/admin/update-teacher/${teacher.id}" method="post">
                                                            <button type="submit" class="btn btn-primary"
                                                                style="padding: 6px 10px;">Modifier</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Section Admin: Gestion des étudiants -->
                        <div id="students" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Étudiants</h2>

                                <!-- Formulaire d'ajout -->
                                <div style="margin-bottom: 30px;">
                                    <h3 style="margin-bottom: 15px; color: #4a5568;">Ajouter un étudiant</h3>
                                    <form action="/admin/add-student" method="post">
                                        <div
                                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                            <div class="form-group">
                                                <label for="studentFullName">Nom complet</label>
                                                <input type="text" id="studentFullName" name="fullName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="studentDOB">Date de naissance</label>
                                                <input type="date" id="studentDOB" name="dateOfBirth" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="studentEmail">Email</label>
                                                <input type="email" id="studentEmail" name="email">
                                            </div>
                                            <div class="form-group">
                                                <label for="studentPhone">Téléphone</label>
                                                <input type="text" id="studentPhone" name="phone">
                                            </div>
                                            <div class="form-group">
                                                <label for="studentAnnee">Année d'Étude</label>
                                                <select id="studentAnnee" name="annee" required>
                                                    <option value="">Sélectionner une année</option>
                                                    <option value="L1">L1</option>
                                                    <option value="L2">L2</option>
                                                    <option value="L3">L3</option>
                                                    <option value="L4">L4</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="option_student">Option Choisie</label>
                                                <select id="optionStudent" name="optionStudent" required>
                                                    <option value="">Sélectionner une option</option>
                                                    <option value="Informatique">Informatique</option>
                                                    <option value="Genie Civil">Genie Civil</option>
                                                    <option value="Electronique">Electronique</option>
                                                    <option value="Gestion">Gestion</option>
                                                    <option value="Economie">Economie</option>
                                                    <option value="Administration">Administration</option>
                                                </select>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary" style="margin-top: 15px;">Ajouter
                                            l'étudiant</button>
                                    </form>
                                </div>

                                <c:if test="${not empty studentUpdateError}">
                                    <div
                                        style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #fecaca; background: #fef2f2; color: #b91c1c;">
                                        ${studentUpdateError}
                                    </div>
                                </c:if>
                                <c:if test="${not empty studentUpdateSuccess}">
                                    <div
                                        style="margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #bbf7d0; background: #f0fdf4; color: #166534;">
                                        ${studentUpdateSuccess}
                                    </div>
                                </c:if>

                                <!-- Liste des étudiants -->
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Code étudiant</th>
                                                <th>Nom complet</th>
                                                <th>Date de naissance</th>
                                                <th>Email</th>
                                                <th>Téléphone</th>
                                                <th>Date d'inscription</th>
                                                <th>Année d'Étude</th>
                                                <th>Option</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${students}">
                                                <tr>
                                                    <td>${student.studentCode}</td>
                                                    <td>
                                                        <input type="text" name="fullName"
                                                            value="${student.fullName}" required
                                                            form="studentUpdateForm${student.id}">
                                                    </td>
                                                    <td>
                                                        <input type="date" name="dateOfBirth"
                                                            value="${student.dateOfBirth}" required
                                                            form="studentUpdateForm${student.id}">
                                                    </td>
                                                    <td>
                                                        <input type="email" name="email"
                                                            value="${student.email}"
                                                            form="studentUpdateForm${student.id}">
                                                    </td>
                                                    <td>
                                                        <input type="text" name="phone"
                                                            value="${student.phone}"
                                                            form="studentUpdateForm${student.id}">
                                                    </td>
                                                    <td><c:out value="${student.registrationDate}" default="-" /></td>
                                                    <td>
                                                        <select name="annee" required
                                                            form="studentUpdateForm${student.id}">
                                                            <option value="L1" ${student.annee eq 'L1' ? 'selected' : ''}>L1</option>
                                                            <option value="L2" ${student.annee eq 'L2' ? 'selected' : ''}>L2</option>
                                                            <option value="L3" ${student.annee eq 'L3' ? 'selected' : ''}>L3</option>
                                                            <option value="L4" ${student.annee eq 'L4' ? 'selected' : ''}>L4</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <select name="optionStudent" required
                                                            form="studentUpdateForm${student.id}">
                                                            <option value="Informatique" ${student.optionStudent eq 'Informatique' ? 'selected' : ''}>Informatique</option>
                                                            <option value="Genie Civil" ${student.optionStudent eq 'Genie Civil' ? 'selected' : ''}>Genie Civil</option>
                                                            <option value="Electronique" ${student.optionStudent eq 'Electronique' ? 'selected' : ''}>Electronique</option>
                                                            <option value="Gestion" ${student.optionStudent eq 'Gestion' ? 'selected' : ''}>Gestion</option>
                                                            <option value="Economie" ${student.optionStudent eq 'Economie' ? 'selected' : ''}>Economie</option>
                                                            <option value="Administration" ${student.optionStudent eq 'Administration' ? 'selected' : ''}>Administration</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <form id="studentUpdateForm${student.id}"
                                                            action="/admin/update-student/${student.id}" method="post">
                                                            <button type="submit" class="btn btn-primary"
                                                                style="padding: 6px 10px;">Modifier</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Section Admin: Gestion des matières -->
                        <div id="subjects" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Matières</h2>

                                <!-- Formulaire d'ajout -->
                                <div style="margin-bottom: 30px;">
                                    <h3 style="margin-bottom: 15px; color: #4a5568;">Créer une affectation de cours</h3>
                                    <form action="/admin/add-subject" method="post">
                                        <div
                                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                            <div class="form-group">
                                                <label for="subjectName">Nom de la matière</label>
                                                <input type="text" id="subjectName" name="subjectName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="subjectTeacher">Professeur</label>
                                                <select id="subjectTeacher" name="teacher.id" required>
                                                    <option value="">Sélectionner un professeur</option>
                                                    <c:forEach var="teacher" items="${teachers}">
                                                        <option value="${teacher.id}">${teacher.fullName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="subjectOption">Option</label>
                                                <select id="subjectOption" name="optionName" required>
                                                    <option value="">Sélectionner une option</option>
                                                    <option value="Informatique">Informatique</option>
                                                    <option value="Genie Civil">Genie Civil</option>
                                                    <option value="Electronique">Electronique</option>
                                                    <option value="Gestion">Gestion</option>
                                                    <option value="Economie">Economie</option>
                                                    <option value="Administration">Administration</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="subjectYear">Année d'étude</label>
                                                <select id="subjectYear" name="studyYear" required>
                                                    <option value="">Sélectionner une année</option>
                                                    <option value="L1">L1</option>
                                                    <option value="L2">L2</option>
                                                    <option value="L3">L3</option>
                                                    <option value="L4">L4</option>
                                                </select>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary" style="margin-top: 15px;">Ajouter
                                            l'affectation</button>
                                    </form>
                                </div>

                                <!-- Liste des matières -->
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Code matière</th>
                                                <th>Nom</th>
                                                <th>Professeur</th>
                                                <th>Option</th>
                                                <th>Année</th>
                                                <th>Date de création</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="subject" items="${subjects}">
                                                <tr>
                                                    <td>${subject.subjectCode}</td>
                                                    <td>${subject.subjectName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${subject.teacher != null}">
                                                                ${subject.teacher.fullName}
                                                            </c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${subject.optionName}</td>
                                                    <td>${subject.studyYear}</td>
                                                    <td><c:out value="${subject.createdAt}" default="-" /></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Section Admin: Gestion des notes -->
                        <div id="grades-admin" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Notes</h2>
                                <h3 style="margin-bottom: 15px; color: #4a5568;">Rechercher les notes d'un etudiant</h3>
                                <form action="/admin/get-grade-student" method="get">
                                    <div
                                        style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                        <div class="form-group">
                                            <label for="subjectName">Code etudiant</label>
                                            <input type="text" id="studentCode" name="studentCode"
                                                value="${adminSearchCode}" required>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary" style="margin-top: 15px;">Rechercher les notes</button>
                                </form>

                                <c:if test="${not empty adminSearchError}">
                                    <div
                                        style="margin-top: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #fecaca; background: #fef2f2; color: #b91c1c;">
                                        ${adminSearchError}
                                    </div>
                                </c:if>
                                <c:if test="${not empty adminSearchSuccess}">
                                    <div
                                        style="margin-top: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #bbf7d0; background: #f0fdf4; color: #166534;">
                                        ${adminSearchSuccess}
                                    </div>
                                </c:if>

                                <c:if test="${not empty selectedStudent}">
                                    <div style="margin-top: 28px;">
                                        <h3 style="margin-bottom: 15px; color: #4a5568;">Notes de
                                            <strong>${selectedStudent.fullName}</strong>
                                        </h3>

                                        <div class="table-container">
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>Matière</th>
                                                        <th>Professeur</th>
                                                        <th>Note</th>
                                                        <th>Mention</th>
                                                        <th>Semestre</th>
                                                        <th>Année</th>
                                                        <th>Action Admin</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="grade" items="${adminGrades}">
                                                        <tr>
                                                            <td>${grade.subject.subjectName}</td>
                                                            <td>${grade.teacher.fullName}</td>
                                                            <td>
                                                                <span class="grade-badge 
                                                            <c:choose>
                                                                <c:when test="${grade.grade >= 70}">grade-excellent</c:when>
                                                                <c:when test="${grade.grade >= 55}">grade-good</c:when>
                                                                <c:when test="${grade.grade >= 50}">grade-average</c:when>
                                                                <c:otherwise>grade-poor</c:otherwise>
                                                            </c:choose>">
                                                                    ${grade.grade}/100
                                                                </span>
                                                            </td>
                                                            <td>${grade.mention}</td>
                                                            <td>${grade.semester}</td>
                                                            <td>${grade.academicYear}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${grade.grade < 55}">
                                                                        <form action="/admin/update-grade/${grade.id}"
                                                                            method="post"
                                                                            style="display: flex; align-items: center; gap: 8px;">
                                                                            <input type="hidden" name="studentCode"
                                                                                value="${selectedStudent.studentCode}">
                                                                            <input type="number" name="newGrade"
                                                                                min="0" max="100" step="0.01"
                                                                                value="${grade.grade}" required
                                                                                style="width: 90px;">
                                                                            <button type="submit" class="btn btn-primary"
                                                                                style="padding: 6px 10px;">Modifier</button>
                                                                        </form>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span style="color: #64748b;">Non autorisé</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty adminGrades}">
                                                        <tr>
                                                            <td colspan="7" style="text-align: center;">Aucune note trouvée
                                                                pour cet étudiant.</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="content-section" style="margin-top: 24px;">
                                            <h3 class="section-title">Bulletin de l'étudiant</h3>

                                            <div style="text-align: center; margin-bottom: 30px;">
                                                <h3>Université INUKA</h3>
                                                <h4>Bulletin de notes</h4>
                                                <p>Année académique: 2025-2026</p>
                                            </div>

                                            <div style="margin-bottom: 20px;">
                                                <p><strong>Nom:</strong> ${selectedStudent.fullName}</p>
                                                <p><strong>Code étudiant:</strong> ${selectedStudent.studentCode} -
                                                    ${selectedStudent.optionStudent} - ${selectedStudent.annee}</p>
                                                <p><strong>Moyenne générale des 2 Semestres:</strong>
                                                    <c:choose>
                                                        <c:when test="${adminAverage != null}">
                                                            ${String.format("%.2f", adminAverage)}/100
                                                        </c:when>
                                                        <c:otherwise>
                                                            Non disponible
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p><strong>Moyenne de la semestre 1:</strong>
                                                    <c:choose>
                                                        <c:when test="${adminAverage1 != null}">
                                                            ${String.format("%.2f", adminAverage1)}/100
                                                        </c:when>
                                                        <c:otherwise>
                                                            Non disponible
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p><strong>Moyenne de la semestre 2:</strong>
                                                    <c:choose>
                                                        <c:when test="${adminAverage2 != null}">
                                                            ${String.format("%.2f", adminAverage2)}/100
                                                        </c:when>
                                                        <c:otherwise>
                                                            Non disponible
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p><strong>Statut Semestre 1:</strong> ${adminStatus1}</p>
                                                <p><strong>Statut Semestre 2:</strong> ${adminStatus2}</p>
                                                <p><strong>Statut Generale:</strong> ${adminStatus}</p>
                                            </div>

                                            <h3 style="margin-top: 30px;">Semestre 1</h3>
                                            <div class="table-container">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Matière</th>
                                                            <th>Coefficient</th>
                                                            <th>Note</th>
                                                            <th>Mention</th>
                                                            <th>Observations</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="grade" items="${adminGrades}">
                                                            <c:if test="${grade.semester eq 'Semestre 1'}">
                                                                <tr>
                                                                    <td>${grade.subject.subjectName}</td>
                                                                    <td>1</td>
                                                                    <td>${grade.grade}/100</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${grade.grade >= 70}">Très
                                                                                bien</c:when>
                                                                            <c:when test="${grade.grade >= 55}">Bien</c:when>
                                                                            <c:when test="${grade.grade >= 50}">Passable</c:when>
                                                                            <c:otherwise>Insuffisant</c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${grade.mention}</td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <h3 style="margin-top: 40px;">Semestre 2</h3>
                                            <div class="table-container">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Matière</th>
                                                            <th>Coefficient</th>
                                                            <th>Note</th>
                                                            <th>Mention</th>
                                                            <th>Observations</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="grade" items="${adminGrades}">
                                                            <c:if test="${grade.semester eq 'Semestre 2'}">
                                                                <tr>
                                                                    <td>${grade.subject.subjectName}</td>
                                                                    <td>1</td>
                                                                    <td>${grade.grade}/100</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${grade.grade >= 70}">Très
                                                                                bien</c:when>
                                                                            <c:when test="${grade.grade >= 55}">Bien</c:when>
                                                                            <c:when test="${grade.grade >= 50}">Passable</c:when>
                                                                            <c:otherwise>Insuffisant</c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${grade.mention}</td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div style="margin-top: 30px; padding-top: 20px; border-top: 2px solid #adadad;">
                                                <p><strong>Légende des mentions:</strong></p>
                                                <ul style="list-style-type: none; padding: 0;">
                                                    <li>≥ 70.00: Réussi avec mention Très Bien</li>
                                                    <li>≥ 55.00: Réussi avec mention Bien</li>
                                                    <li>≥ 50.00: Ajourné</li>
                                                    <li>&lt; 50.00: Échoué</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Section Admin: Cours -->
                        <div id="courses" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Cours</h2>
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Code matière</th>
                                                <th>Cours</th>
                                                <th>Professeur</th>
                                                <th>Option</th>
                                                <th>Année</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="subject" items="${subjects}">
                                                <tr>
                                                    <td>${subject.subjectCode}</td>
                                                    <td>${subject.subjectName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${subject.teacher != null}">
                                                                ${subject.teacher.fullName}
                                                            </c:when>
                                                            <c:otherwise>-</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${subject.optionName}</td>
                                                    <td>${subject.studyYear}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty subjects}">
                                                <tr>
                                                    <td colspan="5" style="text-align: center;">Aucun cours disponible.
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Section Professeur: Gestion des notes -->
                    <c:if test="${userType == 'TEACHER'}">
                        <div id="grades-teacher" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Gestion des Notes</h2>

                                <c:if test="${empty teacherAssignments}">
                                    <div
                                        style="margin-top: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #fecaca; background: #fef2f2; color: #b91c1c;">
                                        Aucune affectation n'est définie pour votre compte. Contactez l'administrateur.
                                    </div>
                                </c:if>

                                <c:if test="${not empty teacherAssignments}">
                                    <div style="margin-bottom: 24px;">
                                        <h3 style="margin-bottom: 15px; color: #4a5568;">Filtrer par affectation</h3>
                                        <form action="/dashboard" method="get">
                                            <input type="hidden" name="activeTab" value="grades-teacher">
                                            <div
                                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px;">
                                                <div class="form-group">
                                                    <label for="gradeOptionFilter">Option</label>
                                                    <select id="gradeOptionFilter" name="optionFilter" required>
                                                        <option value="">Sélectionner une option</option>
                                                        <c:forEach var="optionItem" items="${teacherOptions}">
                                                            <option value="${optionItem}" ${optionItem eq selectedOption ? 'selected' : ''}>
                                                                ${optionItem}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="gradeYearFilter">Année d'étude</label>
                                                    <select id="gradeYearFilter" name="yearFilter" required>
                                                        <option value="">Sélectionner une année</option>
                                                        <c:forEach var="yearItem" items="${teacherStudyYears}">
                                                            <option value="${yearItem}" ${yearItem eq selectedStudyYear ? 'selected' : ''}>
                                                                ${yearItem}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Appliquer le filtre</button>
                                        </form>
                                    </div>

                                    <c:if test="${not empty teacherGradeError}">
                                        <div
                                            style="margin-top: 18px; margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #fecaca; background: #fef2f2; color: #b91c1c;">
                                            ${teacherGradeError}
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty teacherGradeSuccess}">
                                        <div
                                            style="margin-top: 18px; margin-bottom: 18px; padding: 12px 14px; border-radius: 8px; border: 1px solid #bbf7d0; background: #f0fdf4; color: #166534;">
                                            ${teacherGradeSuccess}
                                        </div>
                                    </c:if>

                                    <div style="margin-bottom: 30px;">
                                        <h3 style="margin-bottom: 15px; color: #4a5568;">Ajouter une note</h3>
                                        <p style="margin-bottom: 12px; color: #64748b;">
                                            Affectation active: <strong>${selectedOption}</strong> - <strong>${selectedStudyYear}</strong>
                                        </p>
                                        <form action="/teacher/add-grade" method="post">
                                            <input type="hidden" name="optionFilter" value="${selectedOption}">
                                            <input type="hidden" name="yearFilter" value="${selectedStudyYear}">
                                            <div
                                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                                <div class="form-group">
                                                    <label for="gradeStudent">Étudiant</label>
                                                    <select id="gradeStudent" name="studentId" required>
                                                        <option value="">Sélectionner un étudiant</option>
                                                        <c:forEach var="student" items="${students}">
                                                            <option value="${student.id}">${student.fullName} (${student.studentCode})</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="gradeSubject">Matière</label>
                                                    <select id="gradeSubject" name="subjectId" required>
                                                        <option value="">Sélectionner une matière</option>
                                                        <c:forEach var="subject" items="${subjects}">
                                                            <option value="${subject.id}">${subject.subjectName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="gradeValue">Note (0-100)</label>
                                                    <input type="number" id="gradeValue" name="grade" min="0" max="100"
                                                        step="0.01" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="semester">Semestre</label>
                                                    <select id="semester" name="semester" required>
                                                        <option value="Semestre 1">Semestre 1</option>
                                                        <option value="Semestre 2">Semestre 2</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="academicYear">Année académique</label>
                                                    <input type="text" id="academicYear" name="academicYear"
                                                        value="2025-2026" required>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary"
                                                style="margin-top: 15px;">Enregistrer la note</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${userType == 'TEACHER'}">
                        <div id="my-students" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Mes Étudiants</h2>

                                <c:if test="${not empty teacherAssignments}">
                                    <div style="margin-bottom: 20px;">
                                        <form action="/dashboard" method="get">
                                            <input type="hidden" name="activeTab" value="my-students">
                                            <div
                                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px;">
                                                <div class="form-group">
                                                    <label for="studentOptionFilter">Option</label>
                                                    <select id="studentOptionFilter" name="optionFilter" required>
                                                        <option value="">Sélectionner une option</option>
                                                        <c:forEach var="optionItem" items="${teacherOptions}">
                                                            <option value="${optionItem}" ${optionItem eq selectedOption ? 'selected' : ''}>
                                                                ${optionItem}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="studentYearFilter">Année d'étude</label>
                                                    <select id="studentYearFilter" name="yearFilter" required>
                                                        <option value="">Sélectionner une année</option>
                                                        <c:forEach var="yearItem" items="${teacherStudyYears}">
                                                            <option value="${yearItem}" ${yearItem eq selectedStudyYear ? 'selected' : ''}>
                                                                ${yearItem}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Afficher les étudiants</button>
                                        </form>
                                    </div>
                                </c:if>

                                <p style="margin-bottom: 14px; color: #64748b;">
                                    Filtre actif: <strong>${selectedOption}</strong> - <strong>${selectedStudyYear}</strong>
                                </p>

                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Nom complet</th>
                                                <th>Code étudiant</th>
                                                <th>Option</th>
                                                <th>Année</th>
                                                <th>Email</th>
                                                <th>Téléphone</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${students}">
                                                <tr>
                                                    <td><c:out value="${student.fullName}" /></td>
                                                    <td><c:out value="${student.studentCode}" /></td>
                                                    <td><c:out value="${student.optionStudent}" /></td>
                                                    <td><c:out value="${student.annee}" /></td>
                                                    <td><c:out value="${student.email}" /></td>
                                                    <td><c:out value="${student.phone}" /></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty students}">
                                                <tr>
                                                    <td colspan="6" class="text-center p-3">
                                                        <p class="text-sm font-weight-bold mb-0">Aucun étudiant trouvé pour cette
                                                            affectation.</p>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Section Étudiant: Mes notes -->
                    <c:if test="${userType == 'STUDENT'}">
                        <div id="my-grades" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Mes Notes</h2>

                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Matière</th>
                                                <th>Professeur</th>
                                                <th>Note</th>
                                                <th>Mention</th>
                                                <th>Semestre</th>
                                                <th>Année</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="grade" items="${grades}">
                                                <tr>
                                                    <td>${grade.subject.subjectName}</td>
                                                    <td>${grade.teacher.fullName}</td>
                                                    <td>
                                                        <span class="grade-badge 
                                                    <c:choose>
                                                        <c:when test=" ${grade.grade>= 70}">grade-excellent</c:when>
                                                            <c:when test="${grade.grade >= 55}">grade-good</c:when>
                                                            <c:when test="${grade.grade >= 50}">grade-average</c:when>
                                                            <c:otherwise>grade-poor</c:otherwise>
                                                            </c:choose>">
                                                            ${grade.grade}/100
                                                        </span>
                                                    </td>
                                                    <td>${grade.mention}</td>
                                                    <td>${grade.semester}</td>
                                                    <td>${grade.academicYear}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Section Étudiant: Mon bulletin -->
                        <div id="bulletin" class="tab-content">
                            <div class="content-section">
                                <h2 class="section-title">Mon Bulletin</h2>

                                <div style="text-align: center; margin-bottom: 30px;">
                                    <h3>Université INUKA</h3>
                                    <h4>Bulletin de notes</h4>
                                    <p>Année académique: 2025-2026</p>
                                </div>

                                <div style="margin-bottom: 20px;">
                                    <p><strong>Nom:</strong> ${user.fullName}</p>
                                    <p><strong>Code étudiant:</strong> ${user.studentCode} - ${user.optionStudent} - ${user.annee}</p>
                                    <p><strong>Moyenne générale des 2 Semestres:</strong>
                                        <c:choose>
                                            <c:when test="${average != null}">
                                                ${String.format("%.2f", average)}/100
                                            </c:when>
                                            <c:otherwise>
                                                Non disponible
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p><strong>Moyenne de la semestre 1:</strong>
                                        <c:choose>
                                            <c:when test="${average1 != null}">
                                                ${String.format("%.2f", average1)}/100
                                            </c:when>
                                            <c:otherwise>
                                                Non disponible
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p><strong>Moyenne de la semestre 2:</strong>
                                        <c:choose>
                                            <c:when test="${average2 != null}">
                                                ${String.format("%.2f", average2)}/100
                                            </c:when>
                                            <c:otherwise>
                                                Non disponible
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p><strong>Statut Semestre 1:</strong> ${status1}</p>
                                    <p><strong>Statut Semestre 2:</strong> ${status2}</p>
                                    <p><strong>Statut Generale:</strong> ${status}</p>
                                </div>

                                <h3 style="margin-top: 30px;">Semestre 1</h3>
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Matière</th>
                                                <th>Coefficient</th>
                                                <th>Note</th>
                                                <th>Mention</th>
                                                <th>Observations</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="grade" items="${grades}">
                                                <c:if test="${grade.semester eq 'Semestre 1'}">
                                                    <tr>
                                                        <td>${grade.subject.subjectName}</td>
                                                        <td>1</td>
                                                        <td>${grade.grade}/100</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${grade.grade >= 70}">Très bien</c:when>
                                                                <c:when test="${grade.grade >= 55}">Bien</c:when>
                                                                <c:when test="${grade.grade >= 50}">Passable</c:when>
                                                                <c:otherwise>Insuffisant</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${grade.mention}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <h3 style="margin-top: 40px;">Semestre 2</h3>
                                <div class="table-container">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Matière</th>
                                                <th>Coefficient</th>
                                                <th>Note</th>
                                                <th>Mention</th>
                                                <th>Observations</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="grade" items="${grades}">
                                                <c:if test="${grade.semester eq 'Semestre 2'}">
                                                    <tr>
                                                        <td>${grade.subject.subjectName}</td>
                                                        <td>1</td>
                                                        <td>${grade.grade}/100</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${grade.grade >= 70}">Très bien</c:when>
                                                                <c:when test="${grade.grade >= 55}">Bien</c:when>
                                                                <c:when test="${grade.grade >= 50}">Passable</c:when>
                                                                <c:otherwise>Insuffisant</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${grade.mention}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div style="margin-top: 30px; padding-top: 20px; border-top: 2px solid #adadad;">
                                    <p><strong>Légende des mentions:</strong></p>
                                    <ul style="list-style-type: none; padding: 0;">
                                        <li>≥ 70.00: Réussi avec mention Très Bien</li>
                                        <li>≥ 55.00: Réussi avec mention Bien</li>
                                        <li>≥ 50.00: Ajourné</li>
                                        <li>&lt; 50.00: Échoué</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const navItems = document.querySelectorAll('.nav-item');
                    const tabContents = document.querySelectorAll('.tab-content');
                    const activeTabFromServer = '<c:out value="${activeTab}" default="" />';
                    const tabStorageKey = 'ssm-active-tab';

                    function getStoredTab() {
                        try {
                            return sessionStorage.getItem(tabStorageKey) || '';
                        } catch (error) {
                            return '';
                        }
                    }

                    function storeTab(tabId) {
                        try {
                            sessionStorage.setItem(tabStorageKey, tabId);
                        } catch (error) {
                            // Ignorer les restrictions de stockage navigateur.
                        }
                    }

                    function animateCurrentTab(tabElement) {
                        const sections = tabElement.querySelectorAll('.content-section');
                        sections.forEach((section, index) => {
                            section.style.animation = 'none';
                            section.offsetHeight;
                            section.style.animation = 'contentIn 0.35s ease ' + (index * 0.04) + 's both';
                        });
                    }

                    function activateTab(tabId, options = {}) {
                        const normalizedTab = (tabId || '').replace('#', '').trim();
                        const shouldPersist = options.persist !== false;
                        const shouldUpdateHash = options.updateHash === true;
                        if (!normalizedTab) {
                            return;
                        }

                        const tabElement = document.getElementById(normalizedTab);
                        const navElement = document.querySelector('[data-tab="' + normalizedTab + '"]');
                        if (!tabElement || !navElement) {
                            return;
                        }

                        navItems.forEach(nav => nav.classList.remove('active'));
                        tabContents.forEach(content => content.classList.remove('active'));

                        navElement.classList.add('active');
                        tabElement.classList.add('active');
                        animateCurrentTab(tabElement);

                        if (shouldPersist) {
                            storeTab(normalizedTab);
                        }
                        if (shouldUpdateHash) {
                            window.location.hash = normalizedTab;
                        }
                    }

                    navItems.forEach(item => {
                        item.addEventListener('click', function (e) {
                            e.preventDefault();
                            activateTab(this.getAttribute('data-tab'), { updateHash: true });
                        });
                    });

                    const hash = (window.location.hash || '').replace('#', '').trim();
                    const fallbackTab = hash || activeTabFromServer || getStoredTab() || 'dashboard';
                    activateTab(fallbackTab, { updateHash: false });

                    function setButtonLoading(button, loadingText) {
                        if (!button) {
                            return;
                        }
                        button.classList.add('is-loading');
                        button.disabled = true;
                        button.textContent = loadingText;
                    }

                    const allForms = document.querySelectorAll('form');
                    allForms.forEach(form => {
                        const submitBtn = form.querySelector('button[type="submit"]');
                        if (!submitBtn) {
                            return;
                        }
                        const isInlineUpdateForm = form.id.startsWith('teacherUpdateForm') ||
                            form.id.startsWith('studentUpdateForm');

                        form.addEventListener('submit', function () {
                            setButtonLoading(submitBtn, isInlineUpdateForm ? 'Enregistrement' : 'Traitement');
                        });
                    });

                    const editableForms = document.querySelectorAll('form[id^="teacherUpdateForm"], form[id^="studentUpdateForm"]');
                    editableForms.forEach(form => {
                        const row = form.closest('tr');
                        const submitBtn = form.querySelector('button[type="submit"]');
                        const defaultBtnText = submitBtn ? submitBtn.textContent.trim() : 'Modifier';
                        const linkedInputs = document.querySelectorAll('[form="' + form.id + '"]');
                        const initialValues = new Map();

                        linkedInputs.forEach(input => initialValues.set(input.name, input.value));

                        function updateDirtyState() {
                            let dirty = false;
                            linkedInputs.forEach(input => {
                                if (input.value !== initialValues.get(input.name)) {
                                    dirty = true;
                                }
                            });

                            if (row) {
                                row.classList.toggle('table-row-dirty', dirty);
                            }
                            if (submitBtn && !submitBtn.classList.contains('is-loading')) {
                                submitBtn.textContent = dirty ? 'Enregistrer' : defaultBtnText;
                            }
                        }

                        linkedInputs.forEach(input => {
                            input.addEventListener('input', updateDirtyState);
                            input.addEventListener('change', updateDirtyState);
                        });
                        updateDirtyState();
                    });

                    function animateNumber(element) {
                        if (!element || element.dataset.animated === 'true') {
                            return;
                        }

                        const numericText = element.textContent.replace(/[^0-9.-]/g, '');
                        const target = Number(numericText);
                        if (!Number.isFinite(target)) {
                            return;
                        }

                        const isInteger = Number.isInteger(target);
                        const duration = 900;
                        const startTime = performance.now();
                        element.dataset.animated = 'true';

                        function step(currentTime) {
                            const progress = Math.min((currentTime - startTime) / duration, 1);
                            const eased = 1 - Math.pow(1 - progress, 3);
                            const value = target * eased;
                            element.textContent = isInteger ? Math.round(value) : value.toFixed(2);
                            if (progress < 1) {
                                requestAnimationFrame(step);
                            } else {
                                element.textContent = isInteger ? String(Math.round(target)) : target.toFixed(2);
                            }
                        }

                        requestAnimationFrame(step);
                    }

                    const statNumbers = document.querySelectorAll('.stat-number');
                    if ('IntersectionObserver' in window) {
                        const statObserver = new IntersectionObserver((entries, observer) => {
                            entries.forEach(entry => {
                                if (entry.isIntersecting) {
                                    animateNumber(entry.target);
                                    observer.unobserve(entry.target);
                                }
                            });
                        }, { threshold: 0.6 });

                        statNumbers.forEach(stat => statObserver.observe(stat));
                    } else {
                        statNumbers.forEach(stat => animateNumber(stat));
                    }

                    const logoutBtn = document.querySelector('.logout-btn');
                    if (logoutBtn) {
                        logoutBtn.addEventListener('click', function (event) {
                            if (!window.confirm('Voulez-vous vraiment vous déconnecter ?')) {
                                event.preventDefault();
                            }
                        });
                    }

                    const teacherPasswordInput = document.getElementById('teacherPassword');
                    if (teacherPasswordInput) {
                        teacherPasswordInput.addEventListener('focus', function () {
                            if (!this.value) {
                                const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*';
                                let password = '';
                                for (let i = 0; i < 8; i++) {
                                    password += chars.charAt(Math.floor(Math.random() * chars.length));
                                }
                                this.value = password;
                            }
                        });
                    }
                });
            </script>
        </body>

        </html>
