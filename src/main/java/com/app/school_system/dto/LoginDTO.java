package com.app.school_system.dto;

public class LoginDTO {
    private String username;
    private String password;
    private String userType;
    private String fullName;
    private String studentCode;
    private String teacherCode;
 
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getStudentCode() { return studentCode; }
    public void setStudentCode(String studentCode) { this.studentCode = studentCode; }
    
    public String getTeacherCode() { return teacherCode; }
    public void setTeacherCode(String teacherCode) { this.teacherCode = teacherCode; }
}