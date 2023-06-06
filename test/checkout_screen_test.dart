import 'package:ecom/widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecom/screens/checkout/checkout_screen.dart';

void main() {
  testWidgets('CheckOutScreen renders correctly', (WidgetTester tester) async {
    FlutterError.onError = (details) => print(details.exception);

    await tester.pumpWidget(
      MaterialApp(
        home: CheckOutScreen(),
      ),
    );

    // Verify that the custom app bar is rendered
    expect(find.text('CheckOut'), findsOneWidget);

    // Verify that the order now button is rendered
    expect(find.widgetWithText(ElevatedButton, 'ORDER NOW'), findsOneWidget);

    // Verify that the text form fields are rendered
    expect(find.byType(TextFormField), findsNWidgets(6));

    // Verify that the order summary widget is rendered
    expect(find.byType(OrderSummary), findsOneWidget);

    // Print any remaining exceptions caught during the test
    await tester.pumpAndSettle();
  });
}
