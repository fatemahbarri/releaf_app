import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= USERS =================

  // Register a new user and store additional data in Firestore
  Future<void> registerUser({
    required String name,
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

  // Login user and return user data from Firestore
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

  // Get user data by email
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

  // ================= BINS =================

  // Add a new bin to Firestore
  Future<void> addBin({
    required String binName,
    required String binType,
    required String description,
    required String region,
    required String city,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await _firestore.collection('bins').add({
        'binName': binName,
        'binType': binType,
        'Description': description,
        'Region': region,
        'city': city,
        'isActive': 'Active',
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      throw Exception('Failed to add bin: $e');
    }
  }

  // Fetch all bins
  Future<List<Map<String, dynamic>>> getBins() async {
    try {
      final snapshot = await _firestore.collection('bins').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch bins: $e');
    }
  }

  // Fetch bins filtered by bin type
  Future<List<Map<String, dynamic>>> getBinsByType(String binType) async {
    try {
      final snapshot = await _firestore
          .collection('bins')
          .where('binType', isEqualTo: binType)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch bins by type: $e');
    }
  }

  // Delete a bin by document ID
  Future<void> deleteBin(String id) async {
    try {
      await _firestore.collection('bins').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete bin: $e');
    }
  }

  // Update an existing bin
  Future<void> updateBin({
    required String id,
    required String binName,
    required String binType,
    required String description,
    required String region,
    required String city,
    required double latitude,
    required double longitude,
    required String isActive,
  }) async {
    try {
      await _firestore.collection('bins').doc(id).update({
        'binName': binName,
        'binType': binType,
        'Description': description,
        'Region': region,
        'city': city,
        'isActive': isActive,
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      throw Exception('Failed to update bin: $e');
    }
  }
}
