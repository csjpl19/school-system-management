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
    List<Student> findByOptionStudentAndAnneeOrderByFullNameAsc(String optionStudent, String annee);

    /**
     * Récupère la liste unique des étudiants qui suivent les cours d'un professeur spécifique.
     * La jointure se fait via les affectations de cours (matières du professeur, option + année).
     * @param teacherId L'ID du professeur.
     * @return Une liste d'étudiants.
     */
    @Query("""
            SELECT DISTINCT s
            FROM Student s, Subject sub
            WHERE sub.teacher.id = :teacherId
              AND sub.optionName = s.optionStudent
              AND sub.studyYear = s.annee
            ORDER BY s.fullName
            """)
    List<Student> findStudentsByTeacherId(@Param("teacherId") Long teacherId);

}
