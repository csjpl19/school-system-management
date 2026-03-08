package com.app.school_system.service;

import com.app.school_system.dto.GradeDTO;
import com.app.school_system.model.*;
import com.app.school_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class GradeService {

    public enum TeacherGradeCreateResult {
        CREATED,
        STUDENT_NOT_FOUND,
        SUBJECT_NOT_FOUND,
        TEACHER_NOT_FOUND,
        SUBJECT_NOT_ASSIGNED_TO_TEACHER,
        STUDENT_NOT_IN_SUBJECT_ASSIGNMENT,
        INVALID_GRADE
    }

    public enum AdminGradeUpdateResult {
        UPDATED,
        GRADE_NOT_FOUND,
        STUDENT_MISMATCH,
        NOT_ELIGIBLE,
        INVALID_GRADE
    }

    @Autowired
    private GradeRepository gradeRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private TeacherRepository teacherRepository;

    @Transactional
    public TeacherGradeCreateResult addGrade(GradeDTO gradeDTO, Long teacherId) {
        if (gradeDTO.getGrade() == null
                || gradeDTO.getGrade().compareTo(BigDecimal.ZERO) < 0
                || gradeDTO.getGrade().compareTo(new BigDecimal("100")) > 0) {
            return TeacherGradeCreateResult.INVALID_GRADE;
        }

        Optional<Student> student = studentRepository.findById(gradeDTO.getStudentId());
        if (student.isEmpty()) {
            return TeacherGradeCreateResult.STUDENT_NOT_FOUND;
        }

        Optional<Subject> subject = subjectRepository.findById(gradeDTO.getSubjectId());
        if (subject.isEmpty()) {
            return TeacherGradeCreateResult.SUBJECT_NOT_FOUND;
        }

        Optional<Teacher> teacher = teacherRepository.findById(teacherId);
        if (teacher.isEmpty()) {
            return TeacherGradeCreateResult.TEACHER_NOT_FOUND;
        }

        Subject assignedSubject = subject.get();
        Student selectedStudent = student.get();
        Teacher currentTeacher = teacher.get();

        if (assignedSubject.getTeacher() == null || !assignedSubject.getTeacher().getId().equals(currentTeacher.getId())) {
            return TeacherGradeCreateResult.SUBJECT_NOT_ASSIGNED_TO_TEACHER;
        }

        boolean sameOption = assignedSubject.getOptionName() != null
                && assignedSubject.getOptionName().equalsIgnoreCase(selectedStudent.getOptionStudent());
        boolean sameYear = assignedSubject.getStudyYear() != null
                && assignedSubject.getStudyYear().equalsIgnoreCase(selectedStudent.getAnnee());

        if (!sameOption || !sameYear) {
            return TeacherGradeCreateResult.STUDENT_NOT_IN_SUBJECT_ASSIGNMENT;
        }

        Grade grade = new Grade();
        grade.setStudent(selectedStudent);
        grade.setSubject(assignedSubject);
        grade.setTeacher(currentTeacher);
        grade.setGrade(gradeDTO.getGrade());
        grade.setSemester(gradeDTO.getSemester());
        grade.setAcademicYear(gradeDTO.getAcademicYear());
        grade.setCreatedAt(LocalDateTime.now());
        grade.setUpdatedAt(LocalDateTime.now());
        gradeRepository.save(grade);
        return TeacherGradeCreateResult.CREATED;
    }

    @Transactional
    public Grade updateGrade(Long gradeId, BigDecimal newGrade) {
        Optional<Grade> gradeOpt = gradeRepository.findById(gradeId);
        if (gradeOpt.isPresent()) {
            Grade grade = gradeOpt.get();
            grade.setGrade(newGrade);
            grade.setUpdatedAt(LocalDateTime.now());
            return gradeRepository.save(grade);
        }
        return null;
    }

    @Transactional
    public AdminGradeUpdateResult updateGradeForAdmin(Long gradeId, BigDecimal newGrade, String studentCode) {
        if (newGrade == null || newGrade.compareTo(BigDecimal.ZERO) < 0 || newGrade.compareTo(new BigDecimal("100")) > 0) {
            return AdminGradeUpdateResult.INVALID_GRADE;
        }

        Optional<Grade> gradeOpt = gradeRepository.findById(gradeId);
        if (gradeOpt.isEmpty()) {
            return AdminGradeUpdateResult.GRADE_NOT_FOUND;
        }

        Grade grade = gradeOpt.get();
        if (grade.getStudent() == null || grade.getStudent().getStudentCode() == null ||
                !grade.getStudent().getStudentCode().equalsIgnoreCase(studentCode)) {
            return AdminGradeUpdateResult.STUDENT_MISMATCH;
        }

        if (grade.getGrade() != null && grade.getGrade().compareTo(new BigDecimal("55")) >= 0) {
            return AdminGradeUpdateResult.NOT_ELIGIBLE;
        }

        grade.setGrade(newGrade);
        grade.setUpdatedAt(LocalDateTime.now());
        gradeRepository.save(grade);
        return AdminGradeUpdateResult.UPDATED;
    }

    public List<Grade> getStudentGrades(Long studentId) {
        return gradeRepository.findByStudentId(studentId);
    }

    public Double calculateStudentAverage(Long studentId) {
        return gradeRepository.calculateAverageByStudentId(studentId);
    }

    public Double calculateStudentAverage1(Long studentId) {
        return gradeRepository.calculateAverageSemestre1ByStudentId(studentId);
    }

    public Double calculateStudentAverage2(Long studentId) {
        return gradeRepository.calculateAverageSemestre2ByStudentId(studentId);
    }

    public String getStudentStatus(Double average) {
        if (average == null)
            return "Non évalué";

        if (average >= 70.00) {
            return "Réussi - Mention: Très bien";
        } else if (average >= 55.00) {
            return "Réussi - Mention: Bien";
        } else if (average >= 50.00) {
            return "Réussi - Mention: Ajourné";
        } else {
            return "Échoué";
        }
    }
    public String getStudentStatus1(Double average1){
        if(average1 == null){
            return "Non évalué";
        }
        if(average1 >= 70.00){
            return "Réussi - Mention: Très bien";
        } else if(average1 >= 55.00){
            return "Réussi - Mention: Bien";
        } else if(average1 >= 50.00){
            return "Réussi - Mention: Ajourné";
        } else {
            return "Échoué";
        }
    }
    public String getStudentStatus2(Double average2){
        if(average2 == null){
            return "Non évalué";
        }
        if(average2 >= 70.00){
            return "Réussi - Mention: Très bien";
        } else if(average2 >= 55.00){
            return "Réussi - Mention: Bien";
        } else if(average2 >= 50.00){
            return "Réussi - Mention: Ajourné";
        } else {
            return "Échoué";
        }
    }
}
