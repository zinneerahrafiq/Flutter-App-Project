import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/wishlist',
            );
          },
        ),
      ],
    );
  }

  @override
  Widget? get child => null;

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
