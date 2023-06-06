import 'package:ecom/screens/auth/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SignupPage renders correctly', (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(SignupPage());

    // Then
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(FilledButton), findsOneWidget);
  });
}
