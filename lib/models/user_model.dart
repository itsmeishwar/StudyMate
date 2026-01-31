import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String role; // "student" or "admin"
  final DateTime? createdAt;
  
  // Student-specific fields
  final int totalQuizzes;
  final double averageScore;
  final int studyStreak;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.createdAt,
    this.totalQuizzes = 0,
    this.averageScore = 0.0,
    this.studyStreak = 0,
  });

  // Convert from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? 'student',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      totalQuizzes: data['totalQuizzes'] ?? 0,
      averageScore: (data['averageScore'] ?? 0.0).toDouble(),
      studyStreak: data['studyStreak'] ?? 0,
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'totalQuizzes': totalQuizzes,
      'averageScore': averageScore,
      'studyStreak': studyStreak,
    };
  }

  // CopyWith method
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? role,
    DateTime? createdAt,
    int? totalQuizzes,
    double? averageScore,
    int? studyStreak,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      averageScore: averageScore ?? this.averageScore,
      studyStreak: studyStreak ?? this.studyStreak,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        role,
        createdAt,
        totalQuizzes,
        averageScore,
        studyStreak,
      ];
}
