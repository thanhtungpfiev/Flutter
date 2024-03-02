import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:education_app/core/common/features/course/domain/entities/course_entity.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/chat/data/models/group_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(CourseEntity courseEntity);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage,
        _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> addCourse(CourseEntity courseEntity) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      final courseRef = _firebaseFirestore.collection('courses').doc();
      final groupRef = _firebaseFirestore.collection('groups').doc();
      var courseModel = (courseEntity as CourseModel).copyWith(
        id: courseRef.id,
        groupId: groupRef.id,
      );
      if (courseModel.imageIsFile) {
        final imageRef = _firebaseStorage.ref().child(
              'courses/${courseModel.id}/profile_image/${courseModel.title}-pfp',
            );
        await imageRef.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }
      await courseRef.set(courseModel.toMap());

      final group = GroupModel(
        id: groupRef.id,
        name: courseEntity.title,
        courseId: courseRef.id,
        members: const [],
        groupImageUrl: courseModel.image,
      );

      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<CourseModel>> getCourses() {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _firebaseFirestore.collection('courses').get().then(
            (value) => value.docs
                .map((doc) => CourseModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
