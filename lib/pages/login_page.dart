import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// 1. Tambahkan SingleTickerProviderStateMixin agar class ini bisa jadi vsync animasi
class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Controller Animasi & Objek Animasi
  late AnimationController _animController;
  late Animation<double> _logoScaleAnim;

  // State untuk toggle lihat password
  bool _isPasswordHidden = true;

  // Warna Utama (Theme Colors)
  static const Color primaryColor = Color(0xFF2563EB); // Modern Royal Blue
  static const Color primaryLightColor = Color(0xFFEFF6FF); // Soft Blue Accent
  static const Color textColor = Color(0xFF1E293B);
  static const Color subtitleColor = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();

    // 2. Inisialisasi AnimationController dengan durasi total 1.2 detik
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 3. Efek Bounce elastis khusus Logo/Header
    _logoScaleAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    // 4. Jalankan animasi otomatis saat halaman dibuka
    _animController.forward();
  }

  // Biar gak numpuk history & memori bocor
  @override
  void dispose() {
    _animController.dispose(); // Wajib di-dispose!
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 5. Helper Function untuk animasi muncul berurutan (Staggered)
  Widget _buildAnimatedItem({
    required Widget child,
    required double startDelay, // Dimulai dari detik ke berapa (0.0 s/d 1.0)
  }) {
    // Animasi geser naik dari bawah
    final slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.35), // Mulai sedikit dari bawah
          end: Offset.zero, // Berhenti di posisi asli
        ).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Interval(
              startDelay,
              (startDelay + 0.35).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic, // Efek meluncur halus
            ),
          ),
        );

    // Animasi transparan ke jelas (Fade In)
    final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(
          startDelay,
          (startDelay + 0.3).clamp(0.0, 1.0),
          curve: Curves.easeIn,
        ),
      ),
    );

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(opacity: opacityAnimation, child: child),
    );
  }

  // Header Widget dengan Animasi Scale (Membal/Bounce)
  Widget _buildHeader() {
    return Column(
      children: [
        // Icon dengan efek membal/bounce
        ScaleTransition(
          scale: _logoScaleAnim,
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: primaryLightColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 40,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  // Input Field Email
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(color: subtitleColor, fontSize: 14),
        hintText: 'nama@email.com',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: subtitleColor,
          size: 22,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Email tidak boleh kosong";
        }
        if (!RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
        ).hasMatch(value)) {
          return 'Format email tidak valid';
        }
        return null;
      },
    );
  }

  // Input Field Password
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isPasswordHidden,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: subtitleColor, fontSize: 14),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: subtitleColor,
          size: 22,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: subtitleColor,
            size: 22,
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password tidak boleh kosong";
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  // Tombol Login Utama
  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryColor.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            Navigator.pushNamed(context, '/account_page');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email atau password tidak valid'),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Link Sign Up
  Widget _buildSignupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum punya akun? ',
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sign_up_page');
          },
          child: const Text(
            'Daftar Sekarang',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Header (Icon Bounce membal)
                  _buildHeader(),
                  const SizedBox(height: 36),

                  // 2. Email Field muncul di titik 0.2 detik (Slide Up + Fade In)
                  _buildAnimatedItem(
                    startDelay: 0.2,
                    child: _buildEmailField(),
                  ),
                  const SizedBox(height: 16),

                  // 3. Password Field muncul di titik 0.35 detik
                  _buildAnimatedItem(
                    startDelay: 0.35,
                    child: _buildPasswordField(),
                  ),
                  const SizedBox(height: 28),

                  // 4. Tombol Login muncul di titik 0.5 detik
                  _buildAnimatedItem(
                    startDelay: 0.5,
                    child: _buildLoginButton(context),
                  ),
                  const SizedBox(height: 24),

                  // 5. Link Daftar muncul terakhir di titik 0.65 detik
                  _buildAnimatedItem(
                    startDelay: 0.65,
                    child: _buildSignupLink(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
