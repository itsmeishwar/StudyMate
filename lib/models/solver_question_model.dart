import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SolverQuestionModel extends Equatable {
  final String id;
  final String userId;
  final String question;
  final String? imageUrl;
  final String solution;
  final DateTime solvedAt;

  const SolverQuestionModel({
    required this.id,
    required this.userId,
    required this.question,
    this.imageUrl,
    required this.solution,
    required this.solvedAt,
  });

  // Convert from Firestore document
  factory SolverQuestionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SolverQuestionModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      question: data['question'] ?? '',
      imageUrl: data['imageUrl'],
      solution: data['solution'] ?? '',
      solvedAt: data['solvedAt'] != null
          ? (data['solvedAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'question': question,
      'imageUrl': imageUrl,
      'solution': solution,
      'solvedAt': Timestamp.fromDate(solvedAt),
    };
  }

  // CopyWith method
  SolverQuestionModel copyWith({
    String? id,
    String? userId,
    String? question,
    String? imageUrl,
    String? solution,
    DateTime? solvedAt,
  }) {
    return SolverQuestionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      question: question ?? this.question,
      imageUrl: imageUrl ?? this.imageUrl,
      solution: solution ?? this.solution,
      solvedAt: solvedAt ?? this.solvedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        question,
        imageUrl,
        solution,
        solvedAt,
      ];
}
