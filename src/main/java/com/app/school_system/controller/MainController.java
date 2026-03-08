package com.app.school_system.controller;

import com.app.school_system.dto.LoginDTO;
import com.app.school_system.dto.GradeDTO;
import com.app.school_system.model.*;
import com.app.school_system.service.*;
import com.app.school_system.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Controller
public class MainController {
    private record TeacherAssignment(String optionName, String studyYear) {
    }

    @Autowired
    private AuthService authService;

    @Autowired
    private TeacherRepository teacherRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private SubjectRepository subjectRepository;

    @Autowired
    private GradeService gradeService;

    // Connexion page
    @GetMapping("/")
    public String loginPage(Model model) {
        model.addAttribute("loginDTO", new LoginDTO());
        return "login";
    }

    // Connexion
    @PostMapping("/login")
    public String login(@ModelAttribute LoginDTO loginDTO,
            HttpSession session,
            Model model) {

        Object user = authService.authenticate(loginDTO);

        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("userType", loginDTO.getUserType());

            // Token session
            String sessionToken = authService.generateSessionToken();
            session.setAttribute("sessionToken", sessionToken);

            return "redirect:/dashboard";
        } else {
            model.addAttribute("error", "Identifiants incorrects");
            return "login";
        }
    }

    // Dashboard principal
    @GetMapping("/dashboard")
    public String dashboard(@RequestParam(required = false) String optionFilter,
            @RequestParam(required = false) String yearFilter,
            @RequestParam(required = false) String activeTab,
            HttpSession session,
            Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/";
        }

        Object user = session.getAttribute("user");
        String userType = (String) session.getAttribute("userType");

        model.addAttribute("user", user);
        model.addAttribute("userType", userType);
        if (hasText(activeTab)) {
            model.addAttribute("activeTab", activeTab.trim());
        }

        // Data par user type
        switch (userType) {
            case "ADMIN":
                loadAdminData(model);
                break;
            case "TEACHER":
                loadTeacherData((Teacher) user, optionFilter, yearFilter, model);
                break;
            case "STUDENT":
                loadStudentData((Student) user, model);
                break;
        }

        return "dashboard";
    }

    private void loadAdminData(Model model) {
        List<Teacher> teachers = teacherRepository.findAll();
        List<Student> students = studentRepository.findAll();
        List<Subject> subjects = subjectRepository.findAll();

        model.addAttribute("teachers", teachers);
        model.addAttribute("students", students);
        model.addAttribute("subjects", subjects);
        model.addAttribute("newTeacher", new Teacher());
        model.addAttribute("newStudent", new Student());
        model.addAttribute("newSubject", new Subject());
        model.addAttribute("gradeDTO", new GradeDTO());
    }

    private void loadTeacherData(Teacher teacher, String optionFilter, String yearFilter, Model model) {
        List<Subject> allSubjects = subjectRepository.findByTeacherId(teacher.getId());
        List<Student> studentsLinkedToTeacher = studentRepository.findStudentsByTeacherId(teacher.getId());

        List<TeacherAssignment> assignments = allSubjects.stream()
                .filter(subject -> hasText(subject.getOptionName()) && hasText(subject.getStudyYear()))
                .map(subject -> new TeacherAssignment(subject.getOptionName().trim(), subject.getStudyYear().trim()))
                .distinct()
                .sorted(Comparator.comparing(TeacherAssignment::optionName)
                        .thenComparing(TeacherAssignment::studyYear))
                .toList();

        TeacherAssignment selectedAssignment = null;
        if (!assignments.isEmpty()) {
            selectedAssignment = assignments.stream()
                    .filter(assignment -> assignment.optionName().equalsIgnoreCase(normalize(optionFilter))
                            && assignment.studyYear().equalsIgnoreCase(normalize(yearFilter)))
                    .findFirst()
                    .orElse(assignments.get(0));
        }

        List<Subject> filteredSubjects = new ArrayList<>();
        List<Student> filteredStudents = new ArrayList<>();
        if (selectedAssignment != null) {
            String selectedOption = selectedAssignment.optionName();
            String selectedYear = selectedAssignment.studyYear();

            filteredSubjects = allSubjects.stream()
                    .filter(subject -> selectedOption.equalsIgnoreCase(subject.getOptionName())
                            && selectedYear.equalsIgnoreCase(subject.getStudyYear()))
                    .toList();
            filteredStudents = studentRepository.findByOptionStudentAndAnneeOrderByFullNameAsc(selectedOption, selectedYear);
        }

        Set<String> options = new LinkedHashSet<>();
        Set<String> years = new LinkedHashSet<>();
        assignments.forEach(assignment -> {
            options.add(assignment.optionName());
            years.add(assignment.studyYear());
        });

        model.addAttribute("subjects", filteredSubjects);
        model.addAttribute("students", filteredStudents);
        model.addAttribute("teacherAssignments", assignments);
        model.addAttribute("teacherOptions", new ArrayList<>(options));
        model.addAttribute("teacherStudyYears", new ArrayList<>(years));
        model.addAttribute("selectedOption", selectedAssignment != null ? selectedAssignment.optionName() : "");
        model.addAttribute("selectedStudyYear", selectedAssignment != null ? selectedAssignment.studyYear() : "");
        model.addAttribute("teacherSubjectCount", allSubjects.size());
        model.addAttribute("teacherStudentCount", studentsLinkedToTeacher.size());
        model.addAttribute("gradeDTO", new GradeDTO());
    }

    private void loadStudentData(Student student, Model model) {
        List<Grade> grades = gradeService.getStudentGrades(student.getId());
        Double average = gradeService.calculateStudentAverage(student.getId());
        Double average1 = gradeService.calculateStudentAverage1(student.getId());
        Double average2 = gradeService.calculateStudentAverage2(student.getId());
        String status = gradeService.getStudentStatus(average);
        String status1 = gradeService.getStudentStatus1(average1);
        String status2 =gradeService.getStudentStatus2(average2);

        model.addAttribute("grades", grades);
        model.addAttribute("average", average);
        model.addAttribute("status", status);
        model.addAttribute("average1", average1);
        model.addAttribute("average2", average2);
        model.addAttribute("status1", status1);
        model.addAttribute("status2", status2);
    }

    private void loadStudentDataForAdmin(Student student, Model model) {
        List<Grade> grades = gradeService.getStudentGrades(student.getId());
        Double average = gradeService.calculateStudentAverage(student.getId());
        Double average1 = gradeService.calculateStudentAverage1(student.getId());
        Double average2 = gradeService.calculateStudentAverage2(student.getId());
        String status = gradeService.getStudentStatus(average);
        String status1 = gradeService.getStudentStatus1(average1);
        String status2 = gradeService.getStudentStatus2(average2);

        model.addAttribute("selectedStudent", student);
        model.addAttribute("adminGrades", grades);
        model.addAttribute("adminAverage", average);
        model.addAttribute("adminAverage1", average1);
        model.addAttribute("adminAverage2", average2);
        model.addAttribute("adminStatus", status);
        model.addAttribute("adminStatus1", status1);
        model.addAttribute("adminStatus2", status2);
    }

    // Admin
    @PostMapping("/admin/add-teacher")
    public String addTeacher(@ModelAttribute Teacher teacher, HttpSession session) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("ADMIN")) {
            return "redirect:/";
        }

        // Code unique par prof
        String teacherCode = "TCH" + System.currentTimeMillis();
        teacher.setTeacherCode(teacherCode);
        teacherRepository.save(teacher);

        return "redirect:/dashboard";
    }

    @PostMapping("/admin/add-student")
    public String addStudent(@ModelAttribute Student student, HttpSession session) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("ADMIN")) {
            return "redirect:/";
        }

        // Code unique par etudiant
        String studentCode = "STU" + System.currentTimeMillis();
        student.setStudentCode(studentCode);
        studentRepository.save(student);

        return "redirect:/dashboard";
    }

    @PostMapping("/admin/add-subject")
    public String addSubject(@ModelAttribute Subject subject, HttpSession session) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("ADMIN")) {
            return "redirect:/";
        }

        // Code unique par matiere
        String subjectCode = "SUB" + System.currentTimeMillis();
        subject.setSubjectCode(subjectCode);
        subjectRepository.save(subject);

        return "redirect:/dashboard";
    }

    @GetMapping("/admin/get-grade-student")
    public String getStudentGradesForAdmin(@RequestParam String studentCode,
            HttpSession session,
            Model model) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("ADMIN")) {
            return "redirect:/";
        }

        model.addAttribute("user", session.getAttribute("user"));
        model.addAttribute("userType", session.getAttribute("userType"));
        model.addAttribute("activeTab", "grades-admin");
        loadAdminData(model);

        String normalizedCode = studentCode == null ? "" : studentCode.trim();
        model.addAttribute("adminSearchCode", normalizedCode);

        if (normalizedCode.isEmpty()) {
            model.addAttribute("adminSearchError", "Veuillez saisir un code étudiant.");
            return "dashboard";
        }

        Optional<Student> studentOpt = studentRepository.findByStudentCode(normalizedCode);
        if (studentOpt.isEmpty()) {
            model.addAttribute("adminSearchError", "Aucun étudiant trouvé pour le code: " + normalizedCode);
            return "dashboard";
        }

        loadStudentDataForAdmin(studentOpt.get(), model);
        return "dashboard";
    }

    @PostMapping("/admin/update-grade/{id}")
    public String updateGradeForAdmin(@PathVariable Long id,
            @RequestParam BigDecimal newGrade,
            @RequestParam String studentCode,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("ADMIN")) {
            return "redirect:/";
        }

        String normalizedCode = studentCode == null ? "" : studentCode.trim();
        if (normalizedCode.isEmpty()) {
            redirectAttributes.addFlashAttribute("adminSearchError", "Code étudiant invalide.");
            return "redirect:/dashboard#grades-admin";
        }

        GradeService.AdminGradeUpdateResult result =
                gradeService.updateGradeForAdmin(id, newGrade, normalizedCode);

        switch (result) {
            case UPDATED:
                redirectAttributes.addFlashAttribute("adminSearchSuccess", "La note a été modifiée avec succès.");
                break;
            case NOT_ELIGIBLE:
                redirectAttributes.addFlashAttribute("adminSearchError",
                        "Modification refusée: seules les notes échouées ou ajournées peuvent être modifiées.");
                break;
            case GRADE_NOT_FOUND:
                redirectAttributes.addFlashAttribute("adminSearchError", "Note introuvable.");
                break;
            case STUDENT_MISMATCH:
                redirectAttributes.addFlashAttribute("adminSearchError",
                        "La note ne correspond pas à l'étudiant recherché.");
                break;
            case INVALID_GRADE:
                redirectAttributes.addFlashAttribute("adminSearchError",
                        "La nouvelle note doit être comprise entre 0 et 100.");
                break;
            default:
                redirectAttributes.addFlashAttribute("adminSearchError", "Erreur inattendue.");
                break;
        }

        return "redirect:/admin/get-grade-student?studentCode=" + normalizedCode;
    }

    // Profs ajout note
    @PostMapping("/teacher/add-grade")
    public String addGrade(@ModelAttribute GradeDTO gradeDTO,
            @RequestParam(required = false) String optionFilter,
            @RequestParam(required = false) String yearFilter,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("TEACHER")) {
            return "redirect:/";
        }

        Teacher teacher = (Teacher) session.getAttribute("user");
        GradeService.TeacherGradeCreateResult result = gradeService.addGrade(gradeDTO, teacher.getId());

        switch (result) {
            case CREATED:
                redirectAttributes.addFlashAttribute("teacherGradeSuccess", "La note a été enregistrée avec succès.");
                break;
            case STUDENT_NOT_IN_SUBJECT_ASSIGNMENT:
                redirectAttributes.addFlashAttribute("teacherGradeError",
                        "Cet étudiant n'appartient pas à l'option/année de la matière sélectionnée.");
                break;
            case SUBJECT_NOT_ASSIGNED_TO_TEACHER:
                redirectAttributes.addFlashAttribute("teacherGradeError",
                        "Vous ne pouvez pas attribuer une note pour une matière non affectée à votre compte.");
                break;
            case INVALID_GRADE:
                redirectAttributes.addFlashAttribute("teacherGradeError",
                        "La note doit être comprise entre 0 et 100.");
                break;
            case STUDENT_NOT_FOUND:
                redirectAttributes.addFlashAttribute("teacherGradeError", "Étudiant introuvable.");
                break;
            case SUBJECT_NOT_FOUND:
                redirectAttributes.addFlashAttribute("teacherGradeError", "Matière introuvable.");
                break;
            case TEACHER_NOT_FOUND:
                redirectAttributes.addFlashAttribute("teacherGradeError", "Compte professeur introuvable.");
                break;
            default:
                redirectAttributes.addFlashAttribute("teacherGradeError", "Erreur inattendue.");
                break;
        }

        redirectAttributes.addAttribute("activeTab", "grades-teacher");
        if (hasText(optionFilter)) {
            redirectAttributes.addAttribute("optionFilter", optionFilter.trim());
        }
        if (hasText(yearFilter)) {
            redirectAttributes.addAttribute("yearFilter", yearFilter.trim());
        }
        return "redirect:/dashboard";
    }

    @PostMapping("/teacher/update-grade/{id}")
    public String updateGrade(@PathVariable Long id,
            @RequestParam BigDecimal newGrade,
            HttpSession session) {
        if (session.getAttribute("userType") == null ||
                !session.getAttribute("userType").equals("TEACHER")) {
            return "redirect:/";
        }

        gradeService.updateGrade(id, newGrade);
        return "redirect:/dashboard";
    }

    // deconnexion
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    private static boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }

    private static String normalize(String value) {
        return value == null ? "" : value.trim();
    }
}
