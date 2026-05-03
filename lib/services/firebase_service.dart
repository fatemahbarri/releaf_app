import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= USERS =================

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
        'role': 'user',
        'accountStatus': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': null,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  // ================= LOGIN =================

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

      final adminDoc =
          await _firestore.collection('admins').doc(user.uid).get();

      if (adminDoc.exists) {
        await _firestore.collection('admins').doc(user.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });

        return {
          ...adminDoc.data()!,
          'type': 'admin',
        };
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception('User data not found');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return {
        ...userDoc.data()!,
        'type': 'user',
      };
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  // ================= USERS QUERY =================

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return querySnapshot.docs.first.data();
  }

// ================= BINS =================

  Future<void> addBin({
    required String binName,
    required String binType,
    required String description,
    required String region,
    required String city,
    required double latitude,
    required double longitude,
    required bool isActive,
  }) async {
    await _firestore.collection('bins').add({
      'binName': binName,
      'binType': binType,
      'Description': description,
      'Region': region,
      'city': city,
      'isActive': isActive,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

// ✏️ UPDATE BIN
  Future<void> updateBin({
    required String id,
    required String binName,
    required String binType,
    required String description,
    required String region,
    required String city,
    required double latitude,
    required double longitude,
    required bool isActive, // ✅ صار bool
  }) async {
    await _firestore.collection('bins').doc(id).update({
      'binName': binName,
      'binType': binType,
      'Description': description,
      'Region': region,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

// 📥 GET ALL BINS
  Future<List<Map<String, dynamic>>> getBins() async {
    final snapshot = await _firestore.collection('bins').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

// 📥 GET ACTIVE BINS
  Future<List<Map<String, dynamic>>> getActiveBins() async {
    final snapshot = await _firestore
        .collection('bins')
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

// 📥 GET INACTIVE BINS
  Future<List<Map<String, dynamic>>> getInactiveBins() async {
    final snapshot = await _firestore
        .collection('bins')
        .where('isActive', isEqualTo: false)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

// GET BINS BY TYPE (WITH STATUS)
  Future<List<Map<String, dynamic>>> getBinsByType({
    required String category,
    required bool isActive,
  }) async {
    final snapshot = await _firestore
        .collection('bins')
        .where('binType', isEqualTo: category)
        .where('isActive', isEqualTo: isActive)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

// 🔁 TOGGLE ACTIVE / INACTIVE
  Future<void> toggleBinStatus({
    required String id,
    required bool currentStatus,
  }) async {
    await _firestore.collection('bins').doc(id).update({
      'isActive': !currentStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

// DELETE BIN
  Future<void> deleteBin(String id) async {
    await _firestore.collection('bins').doc(id).delete();
  }
// ================= ISSUES =================

  Future<void> addIssue({
    required String type,
    required String details,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();

    final snapshot = await _firestore
        .collection('issues')
        .where('userId', isEqualTo: user.uid)
        .get();

    final nextNumber = snapshot.docs.length + 1;
    final issueNumber = nextNumber.toString().padLeft(5, '0');

    await _firestore.collection('issues').add({
      'issueNumber': issueNumber,
      'type': type,
      'details': details,
      'userName': userData?['name'] ?? 'Unknown',
      'userEmail': user.email ?? '',
      'userId': user.uid,
      'status': 'pending',
      'adminReply': '',
      'isReadByUser': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getIssues() async {
    final snapshot = await _firestore
        .collection('issues')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getIssuesByStatus(String status) async {
    final snapshot = await _firestore
        .collection('issues')
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  Future<void> updateIssueStatus({
    required String issueId,
    required String status,
  }) async {
    await _firestore.collection('issues').doc(issueId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'isReadByUser': false,
    });
  }
}
