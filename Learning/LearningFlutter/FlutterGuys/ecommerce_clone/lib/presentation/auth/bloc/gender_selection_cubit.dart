import 'package:flutter_bloc/flutter_bloc.dart';

enum Gender {
  men,
  women;

  String get displayName {
    switch (this) {
      case Gender.men:
        return 'Men';
      case Gender.women:
        return 'Women';
    }
  }

  // Convert enum to string for Firestore storage
  String toFirestore() {
    return name; // 'men' or 'women'
  }

  // Convert string from Firestore to enum
  static Gender fromFirestore(String value) {
    switch (value.toLowerCase()) {
      case 'men':
        return Gender.men;
      case 'women':
        return Gender.women;
      default:
        throw ArgumentError('Invalid gender value: $value');
    }
  }

  // Alternative: Convert enum to int for Firestore storage
  int toInt() {
    return index; // 0 for men, 1 for women
  }

  // Alternative: Convert int from Firestore to enum
  static Gender fromInt(int value) {
    switch (value) {
      case 0:
        return Gender.men;
      case 1:
        return Gender.women;
      default:
        throw ArgumentError('Invalid gender index: $value');
    }
  }
}

class GenderSelectionCubit extends Cubit<Gender> {
  GenderSelectionCubit() : super(Gender.men);

  Gender selectedGender = Gender.men;

  void selectGender(Gender gender) {
    selectedGender = gender;
    emit(gender);
  }

  void selectMale() {
    emit(Gender.men);
  }

  void selectFemale() {
    emit(Gender.women);
  }
}
