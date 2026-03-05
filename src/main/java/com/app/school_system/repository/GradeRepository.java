package com.app.school_system.repository;

import com.app.school_system.model.Grade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface GradeRepository extends JpaRepository<Grade, Long> {
    List<Grade> findByStudentId(Long studentId);
    List<Grade> findByTeacherId(Long teacherId);
    List<Grade> findBySubjectId(Long subjectId);
    Optional<Grade> findByStudentIdAndSubjectId(Long studentId, Long subjectId);
    
    //Requete moyenne
    @org.springframework.data.jpa.repository.Query("SELECT AVG(g.grade) FROM Grade g WHERE g.student.id = :studentId")
    Double calculateAverageByStudentId(Long studentId);

    @org.springframework.data.jpa.repository.Query("SELECT AVG(g.grade) FROM Grade g WHERE g.student.id =:studentId AND g.semester = 'Semestre 1'")
    Double calculateAverageSemestre1ByStudentId(Long studentId);

    @org.springframework.data.jpa.repository.Query("SELECT AVG(g.grade) FROM Grade g WHERE g.student.id =:studentId AND g.semester = 'Semestre 2'")
    Double calculateAverageSemestre2ByStudentId(Long studentId);

}