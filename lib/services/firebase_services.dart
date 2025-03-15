import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/firebase_options.dart';
import 'package:project/models/models.dart';

class FirebaseServices {
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static UserModel? _currentUser;

  static UserModel get currentUser {
    if (_currentUser == null) {
      throw Exception(
        '_currentUser không thể là null khi gọi getter này',
      );
    }
    return _currentUser!;
  }

  // Phương thức để lấy stream của người dùng từ Firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews {
    return _firebaseFirestore.collection('users').snapshots();
  }

  /// Tạo tài khoản người dùng
  static Future<bool> createAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// Tạo ra một thể hiện của người dùng
      final UserModel user = UserModel(
        userID: credential.user!.uid,
        userName: userName,
        email: email,
        password: password,

      );

      if (credential.user != null) {
        final docReference = _firebaseFirestore.collection('users').doc(credential.user!.uid);
        final doc = await docReference.get();
        if (doc.exists) {
          return false;
        }
        await docReference.set(user.toJson());
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('Mật khẩu bạn cung cấp quá yếu.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('Tài khoản đã tồn tại với email này.');
      } else {
        debugPrint('Lỗi Firebase: ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('Lỗi hiện tại: $e');
      return false;
    }
  }

  /// Đăng nhập tài khoản
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final doc = await _firebaseFirestore.collection('users').doc(credential.user!.uid).get();
        final data = doc.data();
        if (data != null) {
          _currentUser = UserModel.fromJson(data);
          return true;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('Không tìm thấy người dùng với email này.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Mật khẩu không đúng cho người dùng này.');
      } else {
        debugPrint('Lỗi Firebase: ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('Lỗi hiện tại: $e');
      return false;
    }
  }
}