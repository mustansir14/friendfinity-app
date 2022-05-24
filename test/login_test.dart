import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../lib/login.dart';

void main() {
  testWidgets('login with correct credentials', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: Login(),
      )));
      final emailInput = find.byKey(Key('email'));
      final passwordInput = find.byKey(Key('password'));
      final submitBtn = find.byKey(Key('submit'));
      await tester.enterText(emailInput, "mustansir2001@gmail.com");
      await tester.enterText(passwordInput, "1234asdf");
      await tester.tap(submitBtn);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      final success = find.text("Login Success");
      expect(success, findsNothing);
    });
  });

  testWidgets('login with incorrect credentials', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: Login(),
      )));
      final emailInput = find.byKey(Key('email'));
      final passwordInput = find.byKey(Key('password'));
      final submitBtn = find.byKey(Key('submit'));
      await tester.enterText(emailInput, "mustansir2001@gmail.com");
      await tester.enterText(passwordInput, "asdfhtxcvx");
      await tester.tap(submitBtn);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      final success = find.text("Incorrect Username or Password");
      expect(success, findsOneWidget);
    });
  });

  testWidgets('login with empty credentials', (WidgetTester tester) async {
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: Login(),
      )));
      final emailInput = find.byKey(Key('email'));
      final submitBtn = find.byKey(Key('submit'));
      await tester.tap(submitBtn);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      expect(emailInput, findsOneWidget);
    });
  });
}
