import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/Views/Screens/Auth/login_screen.dart';

void main() {
  group('Input Validation', () {
    testWidgets('Valid Username Input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byKey(Key('username_field')), 'valid_username');

      expect(find.text('valid_username'), findsOneWidget);
    });

    testWidgets('Invalid Username Input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byKey(Key('username_field')), '');

      expect(find.text(''), findsOneWidget);
    });

    testWidgets('Valid Password Input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byKey(Key('password_field')), 'valid_password');

      expect(find.text('valid_password'), findsOneWidget);
    });

    testWidgets('Invalid Password Input', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      await tester.enterText(find.byKey(Key('password_field')), '');

      expect(find.text(''), findsOneWidget);
    });
  });
}
