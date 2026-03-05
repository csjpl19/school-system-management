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
            --primary: #0f766e;
            --primary-strong: #0c5f59;
            --secondary: #f97316;
            --danger: #dc2626;
            --surface: #ffffff;
            --ink-900: #102a43;
            --ink-700: #2f4858;
            --ink-500: #627d98;
            --border: #d8e1e8;
            --shadow-soft: 0 18px 42px rgba(16, 42, 67, 0.12);
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
                radial-gradient(circle at 18% 14%, rgba(15, 118, 110, 0.14) 0%, transparent 44%),
                radial-gradient(circle at 82% 12%, rgba(249, 115, 22, 0.13) 0%, transparent 45%),
                linear-gradient(150deg, #f5f8fa 0%, #fdf5ea 48%, #edf4f3 100%);
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
            background: rgba(15, 118, 110, 0.14);
        }

        body::after {
            width: 280px;
            height: 280px;
            top: -100px;
            right: -90px;
            background: rgba(249, 115, 22, 0.13);
        }

        .login-container {
            position: relative;
            background: rgba(255, 255, 255, 0.92);
            border: 1px solid rgba(216, 225, 232, 0.9);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-soft);
            width: min(600px, 100%);
            padding: 36px;
            overflow: hidden;
            animation: cardIn 0.45s ease;
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
            background: #fff;
            font-size: 0.92rem;
            color: var(--ink-700);
            transition: border-color 0.18s ease, box-shadow 0.18s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.15);
        }

        .user-type {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 9px;
            margin-bottom: 18px;
            padding: 4px;
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            background: #f8fbfc;
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
            border-color: rgba(15, 118, 110, 0.2);
            background: rgba(15, 118, 110, 0.08);
        }

        .user-type input[type="radio"] {
            display: none;
        }

        .user-type input[type="radio"]:checked+label {
            background: linear-gradient(135deg, var(--primary), #1a9d8e);
            color: white;
            border-color: rgba(0, 0, 0, 0.04);
            box-shadow: 0 8px 16px rgba(15, 118, 110, 0.28);
        }

        .login-btn {
            width: 100%;
            margin-top: 4px;
            padding: 12px;
            background: linear-gradient(135deg, var(--primary), #159d8f);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.98rem;
            font-family: inherit;
            font-weight: 600;
            letter-spacing: 0.01em;
            cursor: pointer;
            transition: transform 0.18s ease, box-shadow 0.18s ease, filter 0.18s ease;
        }

        .login-btn:hover {
            filter: brightness(1.03);
            transform: translateY(-1px);
            box-shadow: 0 12px 20px rgba(15, 118, 110, 0.28);
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
            background: linear-gradient(145deg, #ffffff, #f6fbfa);
            border: 1px solid var(--border);
            padding: 12px 14px;
            border-radius: var(--radius-md);
            font-size: 0.78rem;
            color: var(--ink-700);
            line-height: 1.5;
        }

        #admin-fields,
        #teacher-fields,
        #student-fields {
            margin-bottom: 12px;
            padding: 16px 14px 6px;
            border-radius: var(--radius-md);
            border: 1px solid rgba(216, 225, 232, 0.95);
            background: linear-gradient(180deg, #ffffff, #f8fcfb);
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

            #admin-fields,
            #teacher-fields,
            #student-fields {
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

            <div id="admin-fields">
                <div class="form-group">
                    <label for="username">Nom d'utilisateur</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" id="password" name="password" required>
                </div>
            </div>

            <div id="teacher-fields" style="display: none;">
                <div class="form-group">
                    <label for="teacherFullName">Nom complet</label>
                    <input type="text" id="teacherFullName" name="fullName">
                </div>
                <div class="form-group">
                    <label for="teacherPassword">Mot de passe</label>
                    <input type="password" id="teacherPassword" name="password">
                </div>
            </div>

            <div id="student-fields" style="display: none;">
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
            
            const adminFields = document.getElementById('admin-fields');
            const teacherFields = document.getElementById('teacher-fields');
            const studentFields = document.getElementById('student-fields');

            const adminInputs = adminFields.querySelectorAll('input');
            const teacherInputs = teacherFields.querySelectorAll('input');
            const studentInputs = studentFields.querySelectorAll('input');

            function updateFormFields() {
                const selectedType = document.querySelector('input[name="userType"]:checked').value;

                // Cacher tous les conteneurs de champs
                adminFields.style.display = 'none';
                teacherFields.style.display = 'none';
                studentFields.style.display = 'none';

                // Désactiver tous les champs pour qu'ils ne soient pas envoyés
                adminInputs.forEach(input => {
                    input.disabled = true;
                    input.required = false;
                });
                teacherInputs.forEach(input => input.disabled = true);
                studentInputs.forEach(input => input.disabled = true);
                
                // Activer les champs pour le type d'utilisateur sélectionné
                if (selectedType === 'ADMIN') {
                    adminFields.style.display = 'block';
                    adminInputs.forEach(input => {
                        input.disabled = false;
                        input.required = true; // Remettre 'required' pour l'admin
                    });
                } else if (selectedType === 'TEACHER') {
                    teacherFields.style.display = 'block';
                    teacherInputs.forEach(input => input.disabled = false);
                } else if (selectedType === 'STUDENT') {
                    studentFields.style.display = 'block';
                    studentInputs.forEach(input => input.disabled = false);
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
