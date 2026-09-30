import 'package:flutter/material.dart';

class CartItemsamples extends StatelessWidget {
  const CartItemsamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Daftar item cart
        for (int i = 1; i <= 6; i++)
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // Gambar Aset lokal
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 15),
                  child: Image.asset('assets/images/ustApri.png'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
