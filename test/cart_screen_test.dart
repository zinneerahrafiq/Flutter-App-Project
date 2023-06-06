import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecom/screens/cart/cart_screen.dart';
import 'package:ecom/screens/checkout/checkout_screen.dart';
import 'package:ecom/blocs/cart/cart_bloc.dart';
import 'package:ecom/models/cart_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:mockito/mockito.dart';

class MockCartBloc extends Mock implements CartBloc {}

void main() {
  late CartBloc cartBloc;

  setUp(() {
    cartBloc = MockCartBloc();
  });

  tearDown(() {
    cartBloc.close();
  });

  testWidgets(
      'CartScreen displays loading indicator when CartLoading state is received',
      (WidgetTester tester) async {
    when(cartBloc.state).thenAnswer((_) => CartLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'CartScreen displays cart details when CartLoaded state is received',
      (WidgetTester tester) async {
    final products = [
      Product(
        name: 'Product 1',
        category: 'Category 1',
        imageUrl: 'https://example.com/product1.jpg',
        price: 10.0,
        isRecommended: true,
        isPopular: false,
      ),
      Product(
        name: 'Product 2',
        category: 'Category 2',
        imageUrl: 'https://example.com/product2.jpg',
        price: 20.0,
        isRecommended: false,
        isPopular: true,
      ),
    ];
    final cart = Cart(products: products);
    when(cartBloc.state).thenAnswer((_) => CartLoaded(cart: cart));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(),
        ),
      ),
    );

    // Verify that cart details are displayed
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text(cart.freeDeliveryString), findsOneWidget);
    expect(find.text('Add more items'), findsOneWidget);

    for (final product in products) {
      expect(find.text(product.name), findsOneWidget);
      expect(find.text(product.price.toString()), findsOneWidget);
    }
  });

  testWidgets(
      'CartScreen displays error message when CartError state is received',
      (WidgetTester tester) async {
    when(cartBloc.state).thenAnswer((_) => CartError());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(),
        ),
      ),
    );

    expect(find.text('Some error in bloc'), findsOneWidget);
  });

  testWidgets(
      'CartScreen navigates to CheckoutScreen when "GO TO CHECKOUT" button is pressed',
      (WidgetTester tester) async {
    when(cartBloc.state).thenAnswer((_) => CartLoaded(cart: const Cart()));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartScreen(),
        ),
        routes: {
          CheckOutScreen.routeName: (_) => const SizedBox(),
        },
      ),
    );

    await tester.tap(find.text('GO TO CHECKOUT'));
    await tester.pumpAndSettle();

    // Verify that the navigation occurred
    expect(find.byType(CheckOutScreen), findsOneWidget);
  });
}
