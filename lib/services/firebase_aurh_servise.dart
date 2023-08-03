import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthServise {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registation({
    required String email,
    required String password,
  }) async {
     await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> ressetPasword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
