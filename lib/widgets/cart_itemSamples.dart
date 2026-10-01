import 'package:flutter/material.dart';

class CartItemsamples extends StatefulWidget {
  const CartItemsamples({super.key});

  @override
  State<CartItemsamples> createState() => _CartItemsamplesState();
}

class _CartItemsamplesState extends State<CartItemsamples> {
  // Tema Warna (Konsisten)
  static const Color primaryColor = Color(0xFF2563EB); // Royal Blue
  static const Color textColor = Color(0xFF1E293B);
  static const Color subtitleColor = Color(0xFF64748B);

  // 1. Inisialisasi Data Otomatis Menggunakan List.generate
  late List<Map<String, dynamic>> _cartItems;

  @override
  void initState() {
    super.initState();
    // Membuat 6 Item Otomatis Tanpa Input Manual
    _cartItems = List.generate(
      6,
      (index) => {
        'id': index + 1,
        'title': 'Ust Apri Product #${index + 1}', // Nama otomatis
        'variant': 'Varian ${index + 1} • Size L', // Varian otomatis
        'price': (index + 1) * 50000, // Harga otomatis (50rb, 100rb, dst)
        'quantity': 1, // Default jumlah item
        'image': 'assets/images/ustApri.png',
      },
    );
  }

  // Helper Format Rupiah
  String _formatRupiah(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  // Fungsi Tambah Jumlah Item
  void _increaseQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity']++;
    });
  }

  // Fungsi Kurang Jumlah Item
  void _decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      setState(() {
        _cartItems[index]['quantity']--;
      });
    }
  }

  // Fungsi Hapus Item
  void _deleteItem(int index) {
    final deletedItemName = _cartItems[index]['title'];
    setState(() {
      _cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$deletedItemName dihapus dari keranjang'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tampilan jika semua item dihapus
    if (_cartItems.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: const Center(
          child: Column(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 64,
                color: subtitleColor,
              ),
              SizedBox(height: 12),
              Text(
                'Keranjang Belanja Kosong',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // 2. FOR LOOP untuk Menampilkan Semua Item yang Dihasilkan Otomatis
        for (int i = 0; i < _cartItems.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar Produk
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      _cartItems[i]['image'],
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
                const SizedBox(width: 14),

                // Detail Teks (Nama, Varian, Harga) Otomatis
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _cartItems[i]['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _cartItems[i]['variant'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: subtitleColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatRupiah(_cartItems[i]['price']),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Buttons (Delete & Increase/Decrease)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Tombol Delete
                    GestureDetector(
                      onTap: () => _deleteItem(i),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Control Quantity (- / +)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          // Tombol Kurang (-)
                          InkWell(
                            onTap: () => _decreaseQuantity(i),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.remove_rounded,
                                size: 16,
                                color: _cartItems[i]['quantity'] > 1
                                    ? textColor
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),

                          // Angka Jumlah
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              '${_cartItems[i]['quantity']}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),

                          // Tombol Tambah (+)
                          InkWell(
                            onTap: () => _increaseQuantity(i),
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.add_rounded,
                                size: 16,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
