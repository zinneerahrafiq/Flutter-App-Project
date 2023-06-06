import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product(
      {required this.name,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.isRecommended,
      required this.isPopular});

  @override
  List<Object?> get props =>
      [name, category, imageUrl, price, isRecommended, isPopular];

  static Product fromFactory(Map<String, dynamic> snap) {
    Product product = Product(
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      isRecommended: snap['isRecommended'] ?? false,
      isPopular: snap['isPopular'],
      price: snap['price'],
    );
    return product;
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
    );
    return product;
  }

  static List<Product> products = [
    const Product(
        name: 'puma white',
        category: 'Shoes',
        imageUrl:
            "https://images.unsplash.com/photo-1608231387042-66d1773070a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2hvZXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
        price: 2000,
        isRecommended: false,
        isPopular: true),

    const Product(
        name: 'mirror',
        category: 'HouseHold',
        imageUrl:
            "https://images.unsplash.com/photo-1556020685-ae41abfc9365?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWlycm9yJTIwcm9vbXxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
        price: 120,
        isRecommended: true,
        isPopular: false),

    const Product(
        name: 'plain white tshirt',
        category: 'Clothing',
        imageUrl:
            "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dCUyMHNoaXJ0fGVufDB8fDB8fHww&w=1000&q=80",
        price: 320,
        isRecommended: true,
        isPopular: false),

// popular

    const Product(
        name: 'pepsi',
        category: 'pepsi',
        imageUrl:
            "https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        price: 30,
        isRecommended: true,
        isPopular: true),

    const Product(
        name: 'bags',
        category: 'bags',
        imageUrl:
            "https://images.unsplash.com/photo-1559056199-641a0ac8b55e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
        price: 200,
        isRecommended: false,
        isPopular: true),

    const Product(
        name: 'pepsi',
        category: 'pepsi',
        imageUrl:
            "https://images.unsplash.com/photo-1553456558-aff63285bdd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
        price: 50,
        isRecommended: false,
        isPopular: true),
    const Product(
        name: 'bags 3asdfasd',
        category: 'bags',
        imageUrl:
            "https://images.unsplash.com/photo-1559056199-641a0ac8b55e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
        price: 10,
        isRecommended: false,
        isPopular: true),
  ];
}
