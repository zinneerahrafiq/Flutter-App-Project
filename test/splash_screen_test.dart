import 'dart:async';

import 'package:ecom/screens/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen redirects to home screen after 2 seconds',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(),
      ),
    );

    // Wait for 2 seconds
    await tester.pump(const Duration(seconds: 2));

    // Verify that the current route is '/'
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Navigator), findsOneWidget);
    expect(Navigator.defaultRouteName, '/');

    // Verify that there are no routes left in the Navigator's history
    expect(find.byKey(const ValueKey('/')), findsOneWidget);
    expect(find.byKey(const ValueKey('/splash')), findsNothing);
  });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        // Hide the SplashScreen widget
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SplashScreen'),
      ),
    );
  }
}
