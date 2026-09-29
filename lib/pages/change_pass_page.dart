import 'package:flutter/material.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage>
    with SingleTickerProviderStateMixin {
  // Global Key untuk Form Validation
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk semua input field
  final _currentPasswdController = TextEditingController();
  final _newPasswdController = TextEditingController();
  final _confirmPasswdController = TextEditingController();

  // State Toggle Sembunyikan/Lihat Password
  bool _isCurrentPasswordHidden = true;
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  // Animation Controller
  late AnimationController _animController;
  late Animation<double> _iconScaleAnim;

  // Tema Warna (Konsisten dengan LoginPage, SignUpPage, dan AccountPage)
  static const Color primaryColor = Color(0xFF2563EB); // Royal Blue
  static const Color primaryLightColor = Color(0xFFEFF6FF); // Soft Blue Accent
  static const Color textColor = Color(0xFF1E293B);
  static const Color subtitleColor = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();

    // Inisialisasi Durasi Animasi
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Animasi Bounce elastis pada Icon Header Lock
    _iconScaleAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
    );

    // Jalankan animasi secara otomatis saat layar dibuka
    _animController.forward();
  }

  @override
  void dispose() {
    // Dipose controller agar tidak memicu memory leak
    _animController.dispose();
    _currentPasswdController.dispose();
    _newPasswdController.dispose();
    _confirmPasswdController.dispose();
    super.dispose();
  }

  // Helper Widget untuk Animasi Muncul Berurutan (Slide Up + Fade In)
  Widget _buildAnimatedItem({
    required Widget child,
    required double startDelay,
  }) {
    final slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Ganti Password',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Icon Lock & Subtitle (Detik 0.0)
                _buildHeaderIconSection(),
                const SizedBox(height: 32),

                // 2. Input Field Password Saat Ini (Detik 0.15)
                _buildAnimatedItem(
                  startDelay: 0.15,
                  child: _buildCurrentPasswordField(),
                ),
                const SizedBox(height: 18),

                // 3. Input Field Password Baru (Detik 0.30)
                _buildAnimatedItem(
                  startDelay: 0.30,
                  child: _buildNewPasswordField(),
                ),
                const SizedBox(height: 18),

                // 4. Input Field Konfirmasi Password Baru (Detik 0.45)
                _buildAnimatedItem(
                  startDelay: 0.45,
                  child: _buildConfirmPasswordField(),
                ),
                const SizedBox(height: 32),

                // 5. Tombol Simpan Password Baru (Detik 0.60)
                _buildAnimatedItem(
                  startDelay: 0.60,
                  child: _buildSubmitButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Icon dengan Animasi Elastic Bounce
  Widget _buildHeaderIconSection() {
    return Column(
      children: [
        ScaleTransition(
          scale: _iconScaleAnim,
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: primaryLightColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              size: 42,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Buat Password Baru',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Password baru harus berbeda dari password sebelumnya demi keamanan akunmu.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: subtitleColor, height: 1.4),
        ),
      ],
    );
  }

  // Field: Password Saat Ini
  Widget _buildCurrentPasswordField() {
    return TextFormField(
      controller: _currentPasswdController,
      obscureText: _isCurrentPasswordHidden,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: _buildInputDecoration(
        labelText: 'Password Saat Ini',
        prefixIcon: Icons.lock_outline_rounded,
        isHidden: _isCurrentPasswordHidden,
        onToggleVisibility: () {
          setState(() {
            _isCurrentPasswordHidden = !_isCurrentPasswordHidden;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password saat ini tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

  // Field: Password Baru
  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswdController,
      obscureText: _isNewPasswordHidden,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: _buildInputDecoration(
        labelText: 'Password Baru',
        prefixIcon: Icons.key_outlined,
        isHidden: _isNewPasswordHidden,
        onToggleVisibility: () {
          setState(() {
            _isNewPasswordHidden = !_isNewPasswordHidden;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password baru tidak boleh kosong';
        }
        if (value.length < 6) {
          return 'Password minimal 6 karakter';
        }
        if (value == _currentPasswdController.text) {
          return 'Password baru tidak boleh sama dengan password lama';
        }
        return null;
      },
    );
  }

  // Field: Konfirmasi Password Baru
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswdController,
      obscureText: _isConfirmPasswordHidden,
      style: const TextStyle(fontSize: 15, color: textColor),
      decoration: _buildInputDecoration(
        labelText: 'Konfirmasi Password Baru',
        prefixIcon: Icons.check_circle_outline_rounded,
        isHidden: _isConfirmPasswordHidden,
        onToggleVisibility: () {
          setState(() {
            _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Konfirmasi password tidak boleh kosong';
        }
        if (value != _newPasswdController.text) {
          return 'Konfirmasi password tidak cocok';
        }
        return null;
      },
    );
  }

  // Tombol Simpan / Submit Button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _handlePassChange,
        child: const Text(
          'Simpan Password Baru',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Helper Reusable Input Decoration
  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    required bool isHidden,
    required VoidCallback onToggleVisibility,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: subtitleColor, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: subtitleColor, size: 22),
      suffixIcon: IconButton(
        icon: Icon(
          isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: subtitleColor,
          size: 22,
        ),
        onPressed: onToggleVisibility,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
    );
  }

  // Action / Function Handler untuk Validasi Form & Animasi Sukses Pop-up
  void _handlePassChange() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  // Pop-Up Modal Dialog Sukses dengan Animasi Bounce
  void _showSuccessDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
          contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCFCE7), // Light green
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF16A34A), // Green
                  size: 38,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Berhasil Diperbarui!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Password kamu telah berhasil diubah. Silakan gunakan password baru untuk login kembali.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: subtitleColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/account_page',
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Kembali ke Akun',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
