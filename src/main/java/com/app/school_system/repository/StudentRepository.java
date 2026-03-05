package com.app.school_system.repository;

import com.app.school_system.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    Optional<Student> findByStudentCode(String studentCode);
    Optional<Student> findByFullNameAndStudentCode(String fullName, String studentCode);
    boolean existsByStudentCode(String studentCode);

     /**
     * Récupère la liste unique des étudiants qui suivent les cours d'un professeur spécifique.
     * La jointure se fait via l'entité Grade.
     * @param teacherId L'ID du professeur.
     * @return Une liste d'étudiants.
     */
     @Query("SELECT DISTINCT g.student FROM Grade g WHERE g.teacher.id = :teacherId")
     List<Student> findStudentsByTeacherId(@Param("teacherId") Long teacherId);
    
}
