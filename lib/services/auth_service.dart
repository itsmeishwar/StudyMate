import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/core/constants/app_constants.dart';
import 'package:studymate/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user data
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      // Check in student collection first
      final studentDoc = await _firestore
          .collection(FirestoreCollections.student)
          .doc(user.uid)
          .get();

      if (studentDoc.exists) {
        return UserModel.fromFirestore(studentDoc);
      }

      // Check in admin collection
      final adminDoc = await _firestore
          .collection(FirestoreCollections.admin)
          .doc(user.uid)
          .get();

      if (adminDoc.exists) {
        return UserModel.fromFirestore(adminDoc);
      }

      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  // Register with email and password
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      // Create user in Firebase Auth
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('User creation failed');
      }

      // Create user model
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        name: name,
        role: role,
        createdAt: DateTime.now(),
      );

      // Save to appropriate collection based on role
      final collection = role == UserRoles.admin
          ? FirestoreCollections.admin
          : FirestoreCollections.student;

      await _firestore
          .collection(collection)
          .doc(user.uid)
          .set(userModel.toFirestore());

      return userModel;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw Exception('The password provided is too weak');
        case 'email-already-in-use':
          throw Exception('An account already exists for that email');
        case 'invalid-email':
          throw Exception('The email address is invalid');
        default:
          throw Exception('Registration failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Sign in failed');
      }

      // Get user data
      final userData = await getCurrentUserData();
      if (userData == null) {
        throw Exception('User data not found');
      }

      return userData;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email');
        case 'wrong-password':
          throw Exception('Wrong password provided');
        case 'invalid-email':
          throw Exception('The email address is invalid');
        case 'user-disabled':
          throw Exception('This user account has been disabled');
        default:
          throw Exception('Sign in failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception('The email address is invalid');
        case 'user-not-found':
          throw Exception('No user found for that email');
        default:
          throw Exception('Password reset failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    required String role,
    required Map<String, dynamic> data,
  }) async {
    try {
      final collection = role == UserRoles.admin
          ? FirestoreCollections.admin
          : FirestoreCollections.student;

      await _firestore.collection(collection).doc(uid).update(data);
    } catch (e) {
      throw Exception('Profile update failed: $e');
    }
  }

  // Check if user is admin
  Future<bool> isAdmin() async {
    try {
      final user = currentUser;
      if (user == null) return false;

      final adminDoc = await _firestore
          .collection(FirestoreCollections.admin)
          .doc(user.uid)
          .get();

      return adminDoc.exists;
    } catch (e) {
      return false;
    }
  }
}
