import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/core/constants/app_constants.dart';
import 'package:studymate/models/question_model.dart';
import 'package:studymate/models/note_model.dart';
import 'package:studymate/models/quiz_result_model.dart';
import 'package:studymate/models/solver_question_model.dart';
import 'package:studymate/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== QUESTIONS ====================

  // Get questions by subject and difficulty
  Future<List<QuestionModel>> getQuestions({
    required String subject,
    required String difficulty,
    int limit = 10,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirestoreCollections.questions)
          .where('subject', isEqualTo: subject)
          .where('difficulty', isEqualTo: difficulty)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => QuestionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get questions: $e');
    }
  }

  // Get all questions (for admin)
  Stream<List<QuestionModel>> getAllQuestionsStream() {
    return _firestore
        .collection(FirestoreCollections.questions)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => QuestionModel.fromFirestore(doc)).toList());
  }

  // Add question
  Future<void> addQuestion(QuestionModel question) async {
    try {
      await _firestore
          .collection(FirestoreCollections.questions)
          .add(question.toFirestore());
    } catch (e) {
      throw Exception('Failed to add question: $e');
    }
  }

  // Update question
  Future<void> updateQuestion(QuestionModel question) async {
    try {
      await _firestore
          .collection(FirestoreCollections.questions)
          .doc(question.id)
          .update(question.toFirestore());
    } catch (e) {
      throw Exception('Failed to update question: $e');
    }
  }

  // Delete question
  Future<void> deleteQuestion(String questionId) async {
    try {
      await _firestore
          .collection(FirestoreCollections.questions)
          .doc(questionId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete question: $e');
    }
  }

  // ==================== NOTES ====================

  // Get visible notes
  Stream<List<NoteModel>> getVisibleNotesStream() {
    return _firestore
        .collection(FirestoreCollections.notes)
        .where('isVisible', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList());
  }

  // Get notes by subject
  Stream<List<NoteModel>> getNotesBySubjectStream(String subject) {
    return _firestore
        .collection(FirestoreCollections.notes)
        .where('subject', isEqualTo: subject)
        .where('isVisible', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList());
  }

  // Get all notes (for admin)
  Stream<List<NoteModel>> getAllNotesStream() {
    return _firestore
        .collection(FirestoreCollections.notes)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).toList());
  }

  // Add note
  Future<void> addNote(NoteModel note) async {
    try {
      await _firestore
          .collection(FirestoreCollections.notes)
          .add(note.toFirestore());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  // Update note
  Future<void> updateNote(NoteModel note) async {
    try {
      await _firestore
          .collection(FirestoreCollections.notes)
          .doc(note.id)
          .update(note.toFirestore());
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  // Delete note
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore
          .collection(FirestoreCollections.notes)
          .doc(noteId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  // ==================== QUIZ RESULTS ====================

  // Save quiz result
  Future<void> saveQuizResult(QuizResultModel result) async {
    try {
      await _firestore
          .collection(FirestoreCollections.quizResults)
          .add(result.toFirestore());

      // Update user statistics
      await _updateUserQuizStats(result.userId, result.score, result.totalQuestions);
    } catch (e) {
      throw Exception('Failed to save quiz result: $e');
    }
  }

  // Get user quiz results
  Stream<List<QuizResultModel>> getUserQuizResultsStream(String userId) {
    return _firestore
        .collection(FirestoreCollections.quizResults)
        .where('userId', isEqualTo: userId)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => QuizResultModel.fromFirestore(doc))
            .toList());
  }

  // Update user quiz statistics
  Future<void> _updateUserQuizStats(String userId, int score, int totalQuestions) async {
    try {
      final userDoc = await _firestore
          .collection(FirestoreCollections.student)
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = UserModel.fromFirestore(userDoc);
        final totalQuizzes = userData.totalQuizzes + 1;
        final newAverage = ((userData.averageScore * userData.totalQuizzes) +
                (score / totalQuestions * 100)) /
            totalQuizzes;

        await _firestore
            .collection(FirestoreCollections.student)
            .doc(userId)
            .update({
          'totalQuizzes': totalQuizzes,
          'averageScore': newAverage,
        });
      }
    } catch (e) {
      // Don't throw error, just log it
      print('Failed to update user stats: $e');
    }
  }

  // ==================== SOLVER ====================

  // Save solver question
  Future<void> saveSolverQuestion(SolverQuestionModel question) async {
    try {
      await _firestore
          .collection(FirestoreCollections.solverHistory)
          .add(question.toFirestore());
    } catch (e) {
      throw Exception('Failed to save solver question: $e');
    }
  }

  // Get user solver history
  Stream<List<SolverQuestionModel>> getUserSolverHistoryStream(String userId) {
    return _firestore
        .collection(FirestoreCollections.solverHistory)
        .where('userId', isEqualTo: userId)
        .orderBy('solvedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SolverQuestionModel.fromFirestore(doc))
            .toList());
  }

  // Get predefined solver questions (for admin-created solutions)
  Future<List<SolverQuestionModel>> getPredefinedSolutions() async {
    try {
      final querySnapshot = await _firestore
          .collection(FirestoreCollections.solverQuestions)
          .get();

      return querySnapshot.docs
          .map((doc) => SolverQuestionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get predefined solutions: $e');
    }
  }

  // ==================== ADMIN - USER MANAGEMENT ====================

  // Get all students
  Stream<List<UserModel>> getAllStudentsStream() {
    return _firestore
        .collection(FirestoreCollections.student)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList());
  }

  // Get total counts for admin dashboard
  Future<Map<String, int>> getAdminDashboardCounts() async {
    try {
      final studentsCount = await _firestore
          .collection(FirestoreCollections.student)
          .count()
          .get();

      final questionsCount = await _firestore
          .collection(FirestoreCollections.questions)
          .count()
          .get();

      final notesCount = await _firestore
          .collection(FirestoreCollections.notes)
          .count()
          .get();

      final quizResultsCount = await _firestore
          .collection(FirestoreCollections.quizResults)
          .count()
          .get();

      return {
        'students': studentsCount.count ?? 0,
        'questions': questionsCount.count ?? 0,
        'notes': notesCount.count ?? 0,
        'quizAttempts': quizResultsCount.count ?? 0,
      };
    } catch (e) {
      throw Exception('Failed to get dashboard counts: $e');
    }
  }
}
