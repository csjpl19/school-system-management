package com.app.school_system.repository;

import com.app.school_system.model.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, Long> {
    List<Subject> findByTeacherId(Long teacherId);
    Optional<Subject> findBySubjectCode(String subjectCode);
}