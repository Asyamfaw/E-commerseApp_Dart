import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

// 1. Tambahkan SingleTickerProviderStateMixin untuk pengelola waktu animasi
class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _buildNameController = TextEditingController();

  // Animation Controller & Curve Animation untuk Logo
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

    // 2. Set durasi total animasi 1.2 detik
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 3. Animasi Bounce elastis pada Logo Header
    _logoScaleAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    // 4. Jalankan animasi otomatis saat halaman dimuat
    _animController.forward();
  }

  @override
  void dispose() {
    // 5. Bersihkan controller agar tidak terjadi memory leak
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _buildNameController.dispose();
    super.dispose();
  }

  // Helper Widget untuk animasi muncul bertahap (Slide Up + Fade In)
  Widget _buildAnimatedItem({
    required Widget child,
    required double startDelay,
  }) {
    final slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animController,
            curve: Interval(
              startDelay,
              (startDelay + 0.35).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic,
            ),
          ),
        );

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

  // Header dengan Icon Bounce
  Widget _buildHeader() {
    return Column(
      children: [
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
          'Sign up dulu bray',
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

  // Input Field Nama
  Widget _buildNameField() {
    return TextFormField(
      controller: _buildNameController,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: InputDecoration(
        labelText: 'Nama',
        labelStyle: const TextStyle(color: subtitleColor, fontSize: 14),
        hintText: 'John Doe',
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        prefixIcon: const Icon(
          Icons.person_outline,
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
          return "Nama tidak boleh kosong";
        }
        return null;
      },
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

  // Tombol Sign Up
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
          'Sign Up',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Link Login
  Widget _buildSignupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login_page');
          },
          child: const Text(
            'Login sekarang',
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
                  // 1. Header dengan efek Bounce (Detik 0.0)
                  _buildHeader(),
                  const SizedBox(height: 36),

                  // 2. Input Nama (Detik 0.15)
                  _buildAnimatedItem(
                    startDelay: 0.15,
                    child: _buildNameField(),
                  ),
                  const SizedBox(height: 16),

                  // 3. Input Email (Detik 0.30)
                  _buildAnimatedItem(
                    startDelay: 0.30,
                    child: _buildEmailField(),
                  ),
                  const SizedBox(height: 16),

                  // 4. Input Password (Detik 0.45)
                  _buildAnimatedItem(
                    startDelay: 0.45,
                    child: _buildPasswordField(),
                  ),
                  const SizedBox(height: 28),

                  // 5. Tombol Sign Up (Detik 0.60)
                  _buildAnimatedItem(
                    startDelay: 0.60,
                    child: _buildLoginButton(context),
                  ),
                  const SizedBox(height: 24),

                  // 6. Link Ke Login (Detik 0.75)
                  _buildAnimatedItem(
                    startDelay: 0.75,
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
