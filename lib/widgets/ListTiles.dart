import 'package:ecom/models/product_model.dart';
import 'package:flutter/material.dart';

class ListTiles extends StatelessWidget {
  final List<Product> productList;

  const ListTiles({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ListTile(
              leading: Image.network(
                productList[index].imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(productList[index].name),
              subtitle:
                  Text('\$${productList[index].price.toStringAsFixed(2)}'),
              onTap: () {
                // Handle tile onTap event
              },
            ),
          );
        },
      ),
    );
  }
}
