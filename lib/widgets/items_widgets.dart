import 'package:flutter/material.dart';

class ItemsWidgets extends StatelessWidget {
  const ItemsWidgets({super.key});

  final List<String> myProdutcsname = const [
    'outfit',
    'Makanan',
    'Pakaian',
    'Obat-obatan',
    'Skincare',
    'Elektronik',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.7,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < myProdutcsname.length; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "-67%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/MioTertekan.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
