<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&family=Space+Grotesk:wght@500;700&display=swap" />
    <title>School System Management - Connexion</title>
    <style>
        :root {
            --primary: #0e7490;
            --primary-strong: #155e75;
            --secondary: #f59e0b;
            --accent: #0ea5e9;
            --danger: #b91c1c;
            --surface: #ffffff;
            --surface-soft: #f4f8fb;
            --ink-900: #0f172a;
            --ink-700: #1e293b;
            --ink-500: #64748b;
            --border: #d7e2ec;
            --ring: rgba(14, 116, 144, 0.18);
            --shadow-soft: 0 22px 48px rgba(15, 23, 42, 0.14);
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 24px 14px;
            line-height: 1.45;
            background:
                radial-gradient(circle at 18% 14%, rgba(14, 116, 144, 0.15) 0%, transparent 44%),
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
        }

        body::before {
            width: 300px;
            height: 300px;
            bottom: -120px;
            left: -80px;
            background: rgba(14, 116, 144, 0.16);
            filter: blur(1px);
        }

        body::after {
            width: 280px;
            height: 280px;
            top: -100px;
            right: -90px;
            background: rgba(245, 158, 11, 0.14);
            filter: blur(1px);
        }

        .login-container {
            position: relative;
            background: rgba(255, 255, 255, 0.94);
            border: 1px solid rgba(215, 226, 236, 0.95);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-soft);
            width: min(600px, 100%);
            padding: 36px;
            overflow: hidden;
            animation: cardIn 0.45s ease;
            backdrop-filter: blur(8px);
            transition: transform 0.22s ease, box-shadow 0.22s ease;
        }

        .login-container:hover {
            transform: translateY(-2px);
            box-shadow: 0 26px 54px rgba(15, 23, 42, 0.16);
        }

        .login-container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }

        .logo {
            text-align: center;
            margin-bottom: 26px;
        }

        .logo h1 {
            color: var(--ink-900);
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.9rem;
            margin-bottom: 4px;
            letter-spacing: 0.02em;
        }

        .logo p {
            color: var(--ink-500);
            font-size: 0.93rem;
        }

        .role-hint {
            margin-bottom: 12px;
            padding: 10px 12px;
            border-radius: 10px;
            border: 1px solid rgba(14, 116, 144, 0.18);
            background: linear-gradient(135deg, rgba(14, 116, 144, 0.08), rgba(14, 165, 233, 0.08));
            color: var(--primary-strong);
            font-size: 0.84rem;
            font-weight: 600;
            letter-spacing: 0.01em;
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
            border-radius: var(--radius-sm);
            background: var(--surface-soft);
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

        .user-type {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 9px;
            margin-bottom: 18px;
            padding: 4px;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            background: linear-gradient(165deg, #f7fbff, #f8fbfc);
        }

        .user-type label {
            text-align: center;
            padding: 10px 8px;
            border: 1px solid transparent;
            border-radius: 10px;
            cursor: pointer;
            color: var(--ink-700);
            font-weight: 600;
            font-size: 0.84rem;
            transition: transform 0.18s ease, background 0.18s ease, color 0.18s ease, border-color 0.18s ease;
        }

        .user-type label:hover {
            transform: translateY(-1px);
            border-color: rgba(14, 116, 144, 0.2);
            background: rgba(14, 116, 144, 0.08);
        }

        .user-type input[type="radio"] {
            display: none;
        }

        .user-type input[type="radio"]:checked+label {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            border-color: rgba(0, 0, 0, 0.04);
            box-shadow: 0 8px 16px rgba(14, 116, 144, 0.28);
        }

        .login-btn {
            width: 100%;
            margin-top: 4px;
            padding: 12px;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.98rem;
            font-family: inherit;
            font-weight: 600;
            letter-spacing: 0.01em;
            cursor: pointer;
            transition: transform 0.18s ease, box-shadow 0.18s ease, filter 0.18s ease;
            background-size: 140% 140%;
            background-image: linear-gradient(135deg, var(--primary), var(--accent));
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .login-btn:focus-visible {
            outline: none;
            box-shadow: 0 0 0 3px var(--ring), 0 8px 20px rgba(14, 116, 144, 0.24);
        }

        .login-btn:hover {
            filter: brightness(1.03);
            transform: translateY(-1px);
            box-shadow: 0 12px 20px rgba(14, 116, 144, 0.28);
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
            padding: 10px 12px;
            border-radius: 10px;
            margin-bottom: 16px;
            text-align: center;
            font-weight: 600;
        }

        .admin-credentials {
            margin-top: 18px;
            background: linear-gradient(145deg, #ffffff, #f3f8fd);
            border: 1px solid var(--border);
            padding: 12px 14px;
            border-radius: var(--radius-md);
            font-size: 0.78rem;
            color: var(--ink-700);
            line-height: 1.5;
        }

        .auth-panel {
            margin-bottom: 12px;
            padding: 16px 14px 6px;
            border-radius: var(--radius-md);
            border: 1px solid rgba(215, 226, 236, 0.95);
            background: linear-gradient(180deg, #ffffff, #f7fbff);
            transform-origin: top center;
        }

        .auth-panel.is-visible {
            animation: panelIn 0.26s ease;
        }

        @keyframes cardIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes panelIn {
            from {
                opacity: 0;
                transform: translateY(6px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 640px) {
            .login-container {
                padding: 22px 16px;
            }

            .logo h1 {
                font-size: 1.4rem;
            }

            .logo p {
                font-size: 0.84rem;
            }

            .user-type {
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .auth-panel {
                padding: 14px 12px 4px;
            }
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="logo">
            <h1>School System Management</h1>
            <p>Gestion des matières, notes et bulletins</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="/login" method="post">
            <div class="user-type">
                <input type="radio" id="admin" name="userType" value="ADMIN" checked>
                <label for="admin">Administrateur</label>

                <input type="radio" id="teacher" name="userType" value="TEACHER">
                <label for="teacher">Professeur</label>

                <input type="radio" id="student" name="userType" value="STUDENT">
                <label for="student">Étudiant</label>
            </div>
            <div id="roleHint" class="role-hint">Connexion administrateur.</div>

            <div id="admin-fields" class="auth-panel">
                <div class="form-group">
                    <label for="username">Nom d'utilisateur</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" id="password" name="password" required>
                </div>
            </div>

            <div id="teacher-fields" class="auth-panel" style="display: none;">
                <div class="form-group">
                    <label for="teacherFullName">Nom complet</label>
                    <input type="text" id="teacherFullName" name="fullName">
                </div>
                <div class="form-group">
                    <label for="teacherPassword">Mot de passe</label>
                    <input type="password" id="teacherPassword" name="password">
                </div>
            </div>

            <div id="student-fields" class="auth-panel" style="display: none;">
                <div class="form-group">
                    <label for="studentFullName">Nom complet</label>
                    <input type="text" id="studentFullName" name="fullName">
                </div>
                <div class="form-group">
                    <label for="studentCode">Code étudiant</label>
                    <input type="text" id="studentCode" name="studentCode">
                </div>
            </div>

            <button type="submit" class="login-btn">Se connecter</button>
        </form>

        <div class="admin-credentials">
            <strong>Admin par défaut:</strong><br>
            Nom: Admin<br>
            Mot de passe: Admin@SSM
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const userTypeRadios = document.querySelectorAll('input[name="userType"]');
            const roleHint = document.getElementById('roleHint');

            const adminFields = document.getElementById('admin-fields');
            const teacherFields = document.getElementById('teacher-fields');
            const studentFields = document.getElementById('student-fields');

            const adminInputs = adminFields.querySelectorAll('input');
            const teacherInputs = teacherFields.querySelectorAll('input');
            const studentInputs = studentFields.querySelectorAll('input');
            const roleDescriptions = {
                ADMIN: 'Connexion administrateur.',
                TEACHER: 'Accès professeur pour gérer les notes et affectations.',
                STUDENT: 'Accès étudiant pour consulter les notes et le bulletin.'
            };

            function setPanelVisibility(panel, visible) {
                panel.style.display = visible ? 'block' : 'none';
                panel.classList.toggle('is-visible', visible);
            }

            function updateFormFields() {
                const selectedType = document.querySelector('input[name="userType"]:checked').value;

                // Cacher tous les conteneurs de champs
                setPanelVisibility(adminFields, false);
                setPanelVisibility(teacherFields, false);
                setPanelVisibility(studentFields, false);

                // Désactiver tous les champs pour qu'ils ne soient pas envoyés
                adminInputs.forEach(input => {
                    input.disabled = true;
                    input.required = false;
                });
                teacherInputs.forEach(input => {
                    input.disabled = true;
                    input.required = false;
                });
                studentInputs.forEach(input => {
                    input.disabled = true;
                    input.required = false;
                });

                // Activer les champs pour le type d'utilisateur sélectionné
                if (selectedType === 'ADMIN') {
                    setPanelVisibility(adminFields, true);
                    adminInputs.forEach(input => {
                        input.disabled = false;
                        input.required = true;
                    });
                } else if (selectedType === 'TEACHER') {
                    setPanelVisibility(teacherFields, true);
                    teacherInputs.forEach(input => {
                        input.disabled = false;
                        input.required = true;
                    });
                } else if (selectedType === 'STUDENT') {
                    setPanelVisibility(studentFields, true);
                    studentInputs.forEach(input => {
                        input.disabled = false;
                        input.required = true;
                    });
                }

                if (roleHint) {
                    roleHint.textContent = roleDescriptions[selectedType] || '';
                }
            }

            userTypeRadios.forEach(radio => {
                radio.addEventListener('change', updateFormFields);
            });

            // Exécuter au chargement pour définir l'état initial correct
            updateFormFields();
        });
    </script>
</body>

</html>
