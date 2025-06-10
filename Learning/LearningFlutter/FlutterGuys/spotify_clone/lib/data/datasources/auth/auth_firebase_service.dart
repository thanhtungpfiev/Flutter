import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/core/configs/constants/app_urls.dart';
import 'package:spotify_clone/data/datasources/auth/auth_service.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/data/models/auth/user_model.dart';
import 'package:spotify_clone/domain/entities/auth/user_entity.dart';

class AuthFirebaseService extends AuthService {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      // Call Firebase Auth API to create a new user
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: createUserReq.email,
            password: createUserReq.password,
          );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .set({
            'name': createUserReq.fullName,
            'email': userCredential.user?.email,
          });

      // If successful, return the user data
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // If there's an error, return the error message
      return Left(e.message);
    }
  }

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      // Call Firebase Auth API to sign in the user
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: signinUserReq.email,
            password: signinUserReq.password,
          );

      // If successful, return the user data
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // If there's an error, return the error message
      return Left(e.message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user =
          await firebaseFirestore
              .collection('Users')
              .doc(firebaseAuth.currentUser?.uid)
              .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}
