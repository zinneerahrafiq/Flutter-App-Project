import 'package:ecom/models/catergory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecom/models/product_model.dart';
import 'package:ecom/screens/catalog/catalog_screen.dart';
import 'package:ecom/widgets/product_card.dart';

void main() {
  testWidgets('CatalogScreen renders correctly', (WidgetTester tester) async {
    // Create a mock category
    final category = CategoryModel(
        name: 'Test Category',
        imageUrl:
            'https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80');

    // Create mock products
    final products = [
      Product(
          name: 'pepsi',
          category: 'Test Category',
          imageUrl:
              "https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
          price: 10,
          isRecommended: true,
          isPopular: false),
      Product(
          name: 'pepsi',
          category: 'Test Category',
          imageUrl:
              "https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
          price: 10,
          isRecommended: true,
          isPopular: false),
    ];

    // Build the CatalogScreen widget with the mock data
    await tester.pumpWidget(
      MaterialApp(
        home: CatalogScreen(category: category),
      ),
    );

    // Verify that the app bar title is correct
    expect(find.text('Test Category'), findsOneWidget);

    // Verify that the product cards are rendered correctly
    for (final product in products) {
      expect(find.text(product.name), findsOneWidget);
    }
  });

  testWidgets('ProductCard widget is tapped', (WidgetTester tester) async {
    // Create a mock category
    final category = CategoryModel(
        name: 'Test Category',
        imageUrl:
            'https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80');

    // Create a mock product
    final product = Product(
        name: 'pepsi',
        category: 'pepsi',
        imageUrl:
            "https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        price: 10,
        isRecommended: true,
        isPopular: false);

    // Build the CatalogScreen widget with the mock data
    await tester.pumpWidget(
      MaterialApp(
        home: CatalogScreen(category: category),
      ),
    );

    // Find the product card widget
    final productCardFinder = find.byWidgetPredicate(
      (widget) => widget is ProductCard && widget.product == product,
    );

    // Verify that the product card is present
    expect(productCardFinder, findsOneWidget);

    // Tap the product card
    await tester.tap(productCardFinder);

    // Wait for the navigation transition to complete
    await tester.pumpAndSettle();

    // Verify that the product details screen is pushed
    expect(find.text('Product Details'), findsOneWidget);
  });
}
