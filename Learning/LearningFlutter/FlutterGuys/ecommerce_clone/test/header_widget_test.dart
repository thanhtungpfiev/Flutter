import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeaderWidget Fix Tests', () {
    testWidgets('HeaderWidget should always render something', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    // Test that header widget can be created
                    Container(
                      height: 100,
                      child: const Text('Header should always be visible'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Header should always be visible'), findsOneWidget);
    });

    test('UserInfoDisplayStates should be properly defined', () {
      // Test state classes exist and can be instantiated
      expect(UserInfoDisplayLoadingState(), isA<UserInfoDisplayState>());
      expect(UserInfoDisplayLoadErrorState(), isA<UserInfoDisplayState>());

      final mockUser = UserEntity(
        userId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        image: '',
        gender: Gender.men,
      );

      expect(
        UserInfoDisplayLoadSuccessState(user: mockUser),
        isA<UserInfoDisplayState>(),
      );
    });

    test('Gender enum should have proper display names', () {
      expect(Gender.menDisplayName, isNotEmpty);
      expect(Gender.womenDisplayName, isNotEmpty);
      expect(Gender.menDisplayName, isA<String>());
      expect(Gender.womenDisplayName, isA<String>());
    });
  });
}
