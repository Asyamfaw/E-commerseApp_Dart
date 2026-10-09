import 'package:flutter/material.dart';

class ItemsWidgets extends StatefulWidget {
  const ItemsWidgets({super.key});

  @override
  State<ItemsWidgets> createState() => _ItemsWidgetsState();
}

class _ItemsWidgetsState extends State<ItemsWidgets> {
  // Daftar Nama Produk
  final List<String> myProductNames = const [
    'Outfit Modern',
    'Makanan Sehat',
    'Pakaian Casual',
    'Obat-obatan',
    'Skincare Glow',
    'Elektronik Ust Apri',
  ];

  // State untuk Lope / Favorite per item
  late List<bool> isFavoriteList;

  // Tema Warna (Konsisten dengan halaman lain)
  static const Color primaryColor = Color(0xFF2563EB); // Royal Blue
  static const Color textColor = Color(0xFF1E293B);
  static const Color subtitleColor = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();
    isFavoriteList = List.generate(myProductNames.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.63, // Aspek rasio pas agar tidak overflow
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      physics: const NeverScrollableScrollPhysics(), // Agar menyatu dengan ScrollView induk
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: myProductNames.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Badge Diskon & Tombol Favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Badge Diskon
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7), // Soft Light Green
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "-67%",
                      style: TextStyle(
                        color: Color(0xFF16A34A), // Dark Green
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  // Tombol Favorite Interaktif
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavoriteList[i] = !isFavoriteList[i];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavoriteList[i]
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavoriteList[i]
                            ? Colors.redAccent
                            : subtitleColor,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 2. Gambar Produk
              Center(
                child: InkWell(
                  onTap: () {
                    // Bisa ditambahkan navigasi ke Detail Page jika ada
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/ustApri.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: subtitleColor,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 3. Nama Produk (dengan Tooltip & Text Ellipsis)
              Tooltip(
                message: myProductNames[i],
                child: Text(
                  myProductNames[i],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),

              const SizedBox(height: 2),

              // 4. Deskripsi Produk Singkat
              const Text(
                'Deskripsi produk singkat',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: subtitleColor),
              ),

              const Spacer(),

              // 5. Harga & Tombol Tambah ke Keranjang
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rp 99.000',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Tombol Cart dengan Navigasi yang Sudah Diperbaiki
                  Material(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pushNamed(context, '/cart_page');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: primaryColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
