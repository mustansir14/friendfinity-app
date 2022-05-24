import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../lib/signup.dart';
import 'dart:math';
import 'dart:io';

void main() {
  testWidgets('signup correct data.', (tester) async {
    // TODO: Implement test
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: SignUp(),
      )));
      final fnameInput = find.byKey(Key('fname'));
      final lnameInput = find.byKey(Key('lname'));
      final dobInput = find.byKey(Key('dob'));
      final genderInput = find.byKey(Key('gender'));
      final emailInput = find.byKey(Key('email'));
      final passwordInput = find.byKey(Key('password'));
      final cityInput = find.byKey(Key('city'));
      final countryInput = find.byKey(Key('country'));
      final submitBtn = find.byKey(Key('submit'));

      var fname = getRandomString(5);
      var lname = getRandomString(5);
      var email = getRandomString(10) + "@gmail.com";
      var password = "1234asdf";
      var city = "Islamabad";
      var country = "Pakistan";
      await tester.enterText(fnameInput, fname);
      await tester.enterText(lnameInput, lname);
      await tester.enterText(emailInput, email);
      await tester.enterText(passwordInput, password);
      await tester.enterText(cityInput, city);
      await tester.enterText(countryInput, country);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      final success = find.text("Sign up Success");
      expect(success, findsNothing);
    });
  });

  testWidgets('signup invalid password', (tester) async {
    // TODO: Implement test
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: SignUp(),
      )));
      final fnameInput = find.byKey(Key('fname'));
      final lnameInput = find.byKey(Key('lname'));
      final dobInput = find.byKey(Key('dob'));
      final genderInput = find.byKey(Key('gender'));
      final emailInput = find.byKey(Key('email'));
      final passwordInput = find.byKey(Key('password'));
      final cityInput = find.byKey(Key('city'));
      final countryInput = find.byKey(Key('country'));
      final submitBtn = find.byKey(Key('submit'));

      var fname = getRandomString(5);
      var lname = getRandomString(5);
      var email = getRandomString(10) + "@gmail.com";
      var password = "12345679842";
      var city = "Islamabad";
      var country = "Pakistan";
      await tester.enterText(fnameInput, fname);
      await tester.enterText(lnameInput, lname);
      await tester.enterText(emailInput, email);
      await tester.enterText(passwordInput, password);
      await tester.enterText(cityInput, city);
      await tester.enterText(countryInput, country);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      expect(email, findsOneWidget);
    });
  });

  testWidgets('signup empty password', (tester) async {
    // TODO: Implement test
    await tester.runAsync(() async {
      // ASSEMBLE
      await tester.pumpWidget(const ProviderScope(
          child: MaterialApp(
        home: SignUp(),
      )));
      final fnameInput = find.byKey(Key('fname'));
      final lnameInput = find.byKey(Key('lname'));
      final dobInput = find.byKey(Key('dob'));
      final genderInput = find.byKey(Key('gender'));
      final emailInput = find.byKey(Key('email'));
      final passwordInput = find.byKey(Key('password'));
      final cityInput = find.byKey(Key('city'));
      final countryInput = find.byKey(Key('country'));
      final submitBtn = find.byKey(Key('submit'));

      var fname = getRandomString(5);
      var lname = getRandomString(5);
      var email = getRandomString(10) + "@gmail.com";
      var password = "";
      var city = "Islamabad";
      var country = "Pakistan";
      await tester.enterText(fnameInput, fname);
      await tester.enterText(lnameInput, lname);
      await tester.enterText(emailInput, email);
      await tester.enterText(passwordInput, password);
      await tester.enterText(cityInput, city);
      await tester.enterText(countryInput, country);
      await Future.delayed(const Duration(seconds: 5), () {});
      await tester.pump();
      expect(email, findsOneWidget);
    });
  });
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

FlutterError.onError = _onError_ignoreOverflowErrors;

Function _onError_ignoreOverflowErrors = (
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  assert(details != null);
  assert(details.exception != null);
  // ---

  bool ifIsOverflowError = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError)
    ifIsOverflowError = !exception.diagnostics
        .any((e) => e.value.toString().startsWith("A RenderFlex overflowed by"));

  // Ignore if is overflow error.
  if (ifIsOverflowError)
    print('Overflow error.');

  // Throw others errors.
  else
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
};
