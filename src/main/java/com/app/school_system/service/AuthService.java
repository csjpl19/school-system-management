package com.app.school_system.service;

import com.app.school_system.dto.LoginDTO;
import com.app.school_system.model.*;
import com.app.school_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {
    
    @Autowired
    private AdminRepository adminRepository;
    
    @Autowired
    private TeacherRepository teacherRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    public Object authenticate(LoginDTO loginDTO) {
        switch (loginDTO.getUserType().toUpperCase()) {
            case "ADMIN":
                return authenticateAdmin(loginDTO);
            case "TEACHER":
                return authenticateTeacher(loginDTO);
            case "STUDENT":
                return authenticateStudent(loginDTO);
            default:
                return null;
        }
    }
    
    private Admin authenticateAdmin(LoginDTO loginDTO) {
        Optional<Admin> admin = adminRepository.findByUsernameAndPassword(
            loginDTO.getUsername(), 
            loginDTO.getPassword()
        );
        return admin.orElse(null);
    }
    
    private Teacher authenticateTeacher(LoginDTO loginDTO) {
        Optional<Teacher> teacher = teacherRepository.findByFullNameAndPassword(
            loginDTO.getFullName(),
            loginDTO.getPassword()
        );
        return teacher.orElse(null);
    }
    
    private Student authenticateStudent(LoginDTO loginDTO) {
        Optional<Student> student = studentRepository.findByFullNameAndStudentCode(
            loginDTO.getFullName(),
            loginDTO.getStudentCode()
        );
        return student.orElse(null);
    }
    
    public String generateSessionToken() {
        return UUID.randomUUID().toString();
    }
}