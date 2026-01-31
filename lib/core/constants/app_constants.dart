import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF5548E0);
  static const Color primaryLight = Color(0xFF8B85FF);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF6584);
  static const Color accentLight = Color(0xFFFF8FA3);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF16213E);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Colors.white;
  
  // Status Colors
  static const Color success = Color(0xFF00D9A3);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFB800);
  static const Color info = Color(0xFF2196F3);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppSizes {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;
  
  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  
  // Icon Sizes
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;
  
  // Button Heights
  static const double buttonHeightSM = 40.0;
  static const double buttonHeightMD = 48.0;
  static const double buttonHeightLG = 56.0;
}

class AppStrings {
  // App
  static const String appName = 'StudyMate';
  static const String appTagline = 'Your Smart Study Companion';
  
  // Auth
  static const String login = 'Login';
  static const String register = 'Register';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String logout = 'Logout';
  
  // Home
  static const String welcome = 'Welcome';
  static const String dashboard = 'Dashboard';
  static const String totalQuizzes = 'Total Quizzes';
  static const String averageScore = 'Average Score';
  static const String studyStreak = 'Study Streak';
  
  // Quiz
  static const String quiz = 'Quiz';
  static const String quizzes = 'Quizzes';
  static const String startQuiz = 'Start Quiz';
  static const String selectSubject = 'Select Subject';
  static const String selectDifficulty = 'Select Difficulty';
  static const String easy = 'Easy';
  static const String medium = 'Medium';
  static const String hard = 'Hard';
  static const String submit = 'Submit';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String quizHistory = 'Quiz History';
  static const String viewResults = 'View Results';
  static const String retakeQuiz = 'Retake Quiz';
  
  // Notes
  static const String notes = 'Notes';
  static const String myNotes = 'My Notes';
  static const String searchNotes = 'Search notes...';
  static const String bookmarked = 'Bookmarked';
  static const String allNotes = 'All Notes';
  
  // Solver
  static const String solver = 'Question Solver';
  static const String typeQuestion = 'Type Question';
  static const String captureImage = 'Capture Image';
  static const String solverHistory = 'Solver History';
  static const String getSolution = 'Get Solution';
  
  // Profile
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String darkMode = 'Dark Mode';
  static const String notifications = 'Notifications';
  
  // Admin
  static const String adminPanel = 'Admin Panel';
  static const String manageQuizzes = 'Manage Quizzes';
  static const String manageNotes = 'Manage Notes';
  static const String manageSolver = 'Manage Solver';
  static const String manageUsers = 'Manage Users';
  static const String addQuestion = 'Add Question';
  static const String editQuestion = 'Edit Question';
  static const String deleteQuestion = 'Delete Question';
  
  // Common
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String noData = 'No data available';
}

class FirestoreCollections {
  static const String users = 'users';
  static const String admin = 'admin';
  static const String student = 'student';
  static const String questions = 'questions';
  static const String quizzes = 'quizzes';
  static const String notes = 'notes';
  static const String solverQuestions = 'solver_questions';
  static const String quizResults = 'quiz_results';
  static const String solverHistory = 'solver_history';
}

class UserRoles {
  static const String admin = 'admin';
  static const String student = 'student';
}

class QuizDifficulty {
  static const String easy = 'easy';
  static const String medium = 'medium';
  static const String hard = 'hard';
  
  static List<String> get all => [easy, medium, hard];
}

class Subjects {
  static const String mathematics = 'Mathematics';
  static const String physics = 'Physics';
  static const String chemistry = 'Chemistry';
  static const String biology = 'Biology';
  static const String english = 'English';
  static const String computerScience = 'Computer Science';
  
  static List<String> get all => [
    mathematics,
    physics,
    chemistry,
    biology,
    english,
    computerScience,
  ];
}
