import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/widgets/custom_app_bar.dart';
import 'package:ecom/widgets/custom_nav_bar.dart';
import 'package:ecom/widgets/product_carousal.dart';
import 'package:ecom/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test HomeScreen', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify the presence of specific widgets on the screen
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(SectionTitle), findsNWidgets(2));
    expect(find.byType(ProductCarousal), findsNWidgets(2));
    expect(find.byType(CustomNavBar), findsOneWidget);
  });
}
