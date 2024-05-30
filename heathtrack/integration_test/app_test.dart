import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:heathtrack/screens/Login/login_view.dart';
import 'package:heathtrack/screens/Login/register_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test-Login', () {
    testWidgets('Test login, write wrong password field',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('emailTextFormField')), 'abc@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), 'test12345');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Incorrect password!!'), findsWidgets);
    });

    testWidgets('Test login, write wrong email', (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('emailTextFormField')), 'ab132c@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), 'test12345');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('User with this email does not exist!!'), findsWidgets);
    });
    testWidgets('Test login, write wrong famillycode',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('emailTextFormField')), 'abc@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), 'abc123456');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), 'test12345678');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Family code with this email wrong!!'), findsWidgets);
    });
    testWidgets('Test login, not write email', (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(find.byKey(const Key('emailTextFormField')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), 'test12345678');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
    testWidgets('Test login, not write password', (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('emailTextFormField')), 'abc@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), 'test12345678');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
    testWidgets('Test login, not write familyCode',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: LoginView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('emailTextFormField')), 'abc@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('passwordTextFormField')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('familyCodeTextFormField')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
  });
  group('Test-Register', () {
    testWidgets('Test Register, same email already exists',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), 'Puh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')),
          'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), 'test1234578');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldEmail')), 'abc@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('User with same email already exists!'), findsWidgets);
    });
    testWidgets('Test Register, same family code already exists',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), 'Puh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')),
          'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), 'abc12345');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('registerTextFieldEmail')),
          'test100122@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('User with same family code already exists!'),
          findsWidgets);
    });
    testWidgets('Test Register, not write email', (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), 'Puh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')),
          'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), 'puh1001');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldEmail')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
    testWidgets('Test Register, not write username',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')),
          'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), 'puh1001');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldEmail')), 'abc123@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
    testWidgets('Test Register, not write password',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), 'Puh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), 'puh1001');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldEmail')), 'abc123@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
    testWidgets('Test Register, not write family code',
        (WidgetTester tester) async {
      // Load app widget.
      await tester.pumpWidget(const MaterialApp(home: RegisterView()));

      /// Find TextFormField widget by Key and enter text
      await tester.enterText(
          find.byKey(const Key('registerTextFieldUsername')), 'Puh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldPassword')), 'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldRepeatPassword')),
          'abc123456789');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldFamilyCode')), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('registerTextFieldEmail')), 'abc123@gmail.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('Do not empty text field!!'), findsWidgets);
    });
  });
  group('Test-Login', () {});
}
