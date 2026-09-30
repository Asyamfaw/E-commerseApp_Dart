import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context, '/');
              },
              child: const Icon(
                Icons.arrow_back,
                size: 22,
                color: Color.fromARGB(255, 252, 248, 248),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 252, 248, 248),
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.more_vert,
              size: 30,
              color: Color.fromARGB(255, 252, 248, 248),
            ),
          ],
        ),
      ),
    );
  }
}
