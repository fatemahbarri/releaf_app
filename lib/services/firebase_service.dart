import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception('User account was not created');
      }

      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'username': username,
        'email': email,
        'role': email.toLowerCase().endsWith('@releaf.com') ? 'admin' : 'user',
        'accountStatus': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': null,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('This email is already in use');
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address');
      } else if (e.code == 'weak-password') {
        throw Exception('Password is too weak');
      } else {
        throw Exception(e.message ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception('Login failed');
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        throw Exception('User data not found in database');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return doc.data()!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for this email');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password');
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Incorrect email or password');
      } else {
        throw Exception(e.message ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return querySnapshot.docs.first.data();
    } catch (e) {
      throw Exception('Failed to fetch user data');
    }
  }
}
