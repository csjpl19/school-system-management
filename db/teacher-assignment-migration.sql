-- Migration: gestion des affectations admin (professeur + option + année)
-- Cible principale: MySQL 8+

-- 1) Ajouter les colonnes d'affectation sur la table des matières/cours
ALTER TABLE subject
    ADD COLUMN option_name VARCHAR(100) NULL AFTER subject_name,
    ADD COLUMN study_year VARCHAR(10) NULL AFTER option_name;

-- 2) Initialiser les lignes existantes (adapter les valeurs par défaut si nécessaire)
UPDATE subject
SET option_name = COALESCE(option_name, 'Informatique'),
    study_year = COALESCE(study_year, 'L1')
WHERE option_name IS NULL
   OR study_year IS NULL;

-- 3) Rendre ces champs obligatoires
ALTER TABLE subject
    MODIFY option_name VARCHAR(100) NOT NULL,
    MODIFY study_year VARCHAR(10) NOT NULL;

-- 4) Index pour accélérer les filtres prof/admin
CREATE INDEX idx_subject_teacher_option_year ON subject (teacher_id, option_name, study_year);
CREATE INDEX idx_student_option_year ON student (option_student, annee);

-- 5) Contrainte d'unicité pour éviter les doublons d'affectation
-- (une même matière ne peut pas être affectée 2 fois au même prof,
--  pour la même option et la même année)
ALTER TABLE subject
    ADD CONSTRAINT uk_subject_teacher_name_option_year
    UNIQUE (teacher_id, subject_name, option_name, study_year);
