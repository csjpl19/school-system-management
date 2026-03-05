-- Crée l'utilisateur admin par défaut si la table est vide
INSERT INTO admin (username, password, full_name, created_at)
SELECT 'Admin', 'Admin@SSM', 'Administrateur', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM admin WHERE username = 'Admin');
