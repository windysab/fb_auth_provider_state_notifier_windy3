import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_provider_state_notifier_windy/contants/db_contants.dart';
import 'package:fb_auth_provider_state_notifier_windy/models/custom_error.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class AuthRepository {
  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  final fb_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final fb_auth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final signedInuser = userCredential.user!;
      await usersRef.doc(signedInuser.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/300',
        'point': 0,
        'rank': 'bronze',
      });
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
