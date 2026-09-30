import 'package:e_commerce_app/widgets/cart_appbar.dart';
import 'package:e_commerce_app/widgets/cart_bottomNavbar.dart';
import 'package:e_commerce_app/widgets/cart_itemSamples.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Appbar Khusus cart
          const CartAppBar(),
          // Isi halaman.
          Container(
            height: 800,
            padding: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 149, 249, 235),
            ),
            child: Column(
              children: [
                // List Item
                const CartItemsamples(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CartBottomnavbar(),
    );
  }
}
