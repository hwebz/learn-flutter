import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> signin(SigninUserRequest signinUserRequest);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserRequest.email, password: signinUserRequest.password);

      return const Right('Signin was successfully');
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';

      if (e.code == 'invalid-email') {
        message = 'User not found for that email.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        message = 'Invalid email/password combination.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try {
      UserCredential data = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: createUserRequest.email,
              password: createUserRequest.password);

      FirebaseFirestore.instance.collection('Users').add({
        'email': data.user?.email,
        'uid': data.user?.uid,
        'name': createUserRequest.name,
      });

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      }
      return Left(message);
    }
  }
}
