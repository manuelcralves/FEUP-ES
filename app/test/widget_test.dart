import 'package:app/Index/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/login/login_frontend.dart';

void main() {
  testWidgets('Invalid email format validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login_Page()));

    // Enter invalid email format.
    await tester.enterText(find.byKey(Key('email')), 'invalidemail');
    await tester.enterText(find.byKey(Key('password')), 'password');

    // Tap the Login button and trigger a frame.
    await tester.tap(find.byKey(Key('Sign In')));
    await tester.pump();

    // Verify that an error message is displayed for invalid email format.
    expect(find.text('Email or password are incorrect.'), findsNothing);
  });

  testWidgets('Valid login', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login_Page()));

    // Enter valid email and password.
    await tester.enterText(find.byKey(Key('email')), 'hey@gmail.com');
    await tester.enterText(find.byKey(Key('password')), '123456');

    // Tap the Login button and trigger a frame.
    await tester.tap(find.byKey(Key('Sign In')));
    await tester.pump();

    // Verify that the Index page is displayed.
    expect(find.byType(Index), findsNothing);
  });

  
}
