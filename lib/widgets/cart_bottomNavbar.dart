import 'package:flutter/material.dart';

class CartBottomnavbar extends StatefulWidget {
  const CartBottomnavbar({super.key});

  @override
  State<CartBottomnavbar> createState() => _CartBottomnavbarState();
}

class _CartBottomnavbarState extends State<CartBottomnavbar> {
  double _buttonScale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _buttonScale = 0.95; // Efek mengecil saat ditekan
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _buttonScale = 1.0; // Kembali ke ukuran semula
    });
  }

  void _onTapCancel() {
    setState(() {
      _buttonScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              Text(
                'Rp 1.125.000',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fitur Tugas No. 2: Tombol Check Out dengan Animasi Tekan (Scale Effect)
          GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Memproses Check Out...'),
                  backgroundColor: Color(0xFF2563EB),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: AnimatedScale(
              scale: _buttonScale,
              duration: const Duration(milliseconds: 100),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Check Out Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
