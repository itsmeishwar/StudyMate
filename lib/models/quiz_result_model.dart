import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:studymate/models/question_model.dart';

class QuizResultModel extends Equatable {
  final String id;
  final String userId;
  final String subject;
  final String difficulty;
  final List<QuestionModel> questions;
  final List<int> userAnswers; // Indices of selected answers
  final int score;
  final int totalQuestions;
  final int timeTaken; // in seconds
  final DateTime completedAt;

  const QuizResultModel({
    required this.id,
    required this.userId,
    required this.subject,
    required this.difficulty,
    required this.questions,
    required this.userAnswers,
    required this.score,
    required this.totalQuestions,
    required this.timeTaken,
    required this.completedAt,
  });

  // Calculate percentage
  double get percentage => (score / totalQuestions) * 100;

  // Convert from Firestore document
  factory QuizResultModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuizResultModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      subject: data['subject'] ?? '',
      difficulty: data['difficulty'] ?? 'easy',
      questions: [], // Questions are stored separately
      userAnswers: List<int>.from(data['userAnswers'] ?? []),
      score: data['score'] ?? 0,
      totalQuestions: data['totalQuestions'] ?? 0,
      timeTaken: data['timeTaken'] ?? 0,
      completedAt: data['completedAt'] != null
          ? (data['completedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'subject': subject,
      'difficulty': difficulty,
      'userAnswers': userAnswers,
      'score': score,
      'totalQuestions': totalQuestions,
      'timeTaken': timeTaken,
      'completedAt': Timestamp.fromDate(completedAt),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        subject,
        difficulty,
        questions,
        userAnswers,
        score,
        totalQuestions,
        timeTaken,
        completedAt,
      ];
}
