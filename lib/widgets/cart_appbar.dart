import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onClearCart;

  const CartAppBar({super.key, this.itemCount = 0, this.onClearCart});

  static const Color primaryColor = Color(0xFF2563EB);
  static const Color textPrimaryColor = Color(0xFF0F172A);
  static const Color textSecondaryColor = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);
  static const Color badgeBgColor = Color(0xFFEFF6FF);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Baris 1: Global ElectroMart Header
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.bolt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'ElectroMart',
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Cart',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/MioTertekan.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: badgeBgColor,
                          child: const Icon(
                            Icons.person,
                            size: 20,
                            color: primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Divider(height: 1, thickness: 1, color: borderColor),

        // Baris 2: Sub-AppBar Keranjang Belanja
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: textPrimaryColor,
                  size: 22,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Keranjang Belanja',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: textPrimaryColor,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$itemCount item terpilih siap diproses',
                      style: const TextStyle(
                        fontSize: 12,
                        color: textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (onClearCart != null && itemCount > 0)
                IconButton(
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    color: textSecondaryColor,
                    size: 22,
                  ),
                  tooltip: 'Kosongkan Keranjang',
                  onPressed: onClearCart,
                ),
            ],
          ),
        ),

        // Baris 3: Banner Gratis Ongkir Super Cepat Aktif
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: badgeBgColor,
            border: const Border(
              bottom: BorderSide(color: primaryColor, width: 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Gratis Ongkir Super Cepat Aktif',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                'Maks. Rp 40.000',
                style: TextStyle(fontSize: 11, color: textSecondaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
