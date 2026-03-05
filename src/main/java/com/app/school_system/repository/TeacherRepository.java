package com.app.school_system.repository;

import com.app.school_system.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {
    Optional<Teacher> findByTeacherCode(String teacherCode);
    Optional<Teacher> findByFullNameAndPassword(String fullName, String password);
    boolean existsByTeacherCode(String teacherCode);
}