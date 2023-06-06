import 'package:ecom/screens/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecom/models/product_model.dart';

void main() {
  testWidgets('ProductDetail screen displays product information correctly',
      (WidgetTester tester) async {
    // Create a test product
    final product = Product(
      name: 'Test Product',
      price: 19.99,
      category: 'smoothies',
      imageUrl: '',
      isPopular: true,
      isRecommended: false,
    );

    // Pump the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetail(product: product),
      ),
    );

    // Verify that the product name is displayed
    expect(find.text('Test Product'), findsOneWidget);

    // Verify that the product price is displayed
    expect(find.text('\$19.99'), findsOneWidget);

    // Verify that the product description is displayed
    expect(
      find.text('This is a test product'),
      findsOneWidget,
    );

    // Verify that the "Add To Cart" button is displayed
    expect(find.text('Add To Cart'), findsOneWidget);
  });
}
