import 'package:flutter/material.dart';

class CategoriesWidgets extends StatelessWidget {
  const CategoriesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'outfit',
      'Makanan',
      'Pakaian',
      'Obat-obatan',
      'Skincare',
      'Elektronik',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/ustApri.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    categories[i],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
