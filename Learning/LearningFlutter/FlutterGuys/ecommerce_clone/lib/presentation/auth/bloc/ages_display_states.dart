import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AgesDisplayState {}

class AgesDisplayLoadingState extends AgesDisplayState {}

class AgesDisplaySuccessState extends AgesDisplayState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> ages;
  AgesDisplaySuccessState({required this.ages});
}

class AgesDisplayLoadErrorState extends AgesDisplayState {
  final String errorMessage;

  AgesDisplayLoadErrorState({required this.errorMessage});
}
