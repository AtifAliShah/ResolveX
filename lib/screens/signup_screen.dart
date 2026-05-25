// lib/screens/signup_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _isLoading = false;
  bool _agreeToTerms = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _animController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Include at least one uppercase letter';
    }
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to the Terms & Privacy Policy',
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          backgroundColor: const Color(0xFFFF6584),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    await context.read<AppProvider>().login(name, email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎉 Welcome to ResolveX, $name!',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: const Color(0xFF11998E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    Navigator.of(context).pushReplacementNamed('/main');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: isDark
                    ? [const Color(0xFF0F0F1A), const Color(0xFF1A1535)]
                    : [const Color(0xFFF5F3FF), const Color(0xFFEEECFF)],
              ),
            ),
          ),

          // Decorative circles
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF6584).withOpacity(isDark ? 0.12 : 0.09),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    const Color(0xFF6C63FF).withOpacity(isDark ? 0.12 : 0.09),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isDark
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 10,
                                    ),
                                  ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 44),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),

                            // Header
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFF6584),
                                          Color(0xFF6C63FF),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFF6584)
                                              .withOpacity(0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text('🚀',
                                          style: TextStyle(fontSize: 32)),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Join ResolveX',
                                    style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF1A1A2E),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Start solving problems today',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: isDark
                                          ? Colors.white.withOpacity(0.5)
                                          : const Color(0xFF888888),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Form Card
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1E1E2E)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(isDark ? 0.25 : 0.08),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // Full name
                                    CustomTextField(
                                      hint: 'Full name',
                                      prefixIcon: Icons.person_outline_rounded,
                                      controller: _nameController,
                                      focusNode: _nameFocus,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context)
                                              .requestFocus(_emailFocus),
                                      validator: _validateName,
                                    ),
                                    const SizedBox(height: 14),

                                    // Email
                                    CustomTextField(
                                      hint: 'Email address',
                                      prefixIcon: Icons.email_outlined,
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _emailFocus,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context)
                                              .requestFocus(_passwordFocus),
                                      validator: _validateEmail,
                                    ),
                                    const SizedBox(height: 14),

                                    // Password
                                    CustomTextField(
                                      hint: 'Password (min. 6 chars + uppercase)',
                                      prefixIcon: Icons.lock_outline_rounded,
                                      controller: _passwordController,
                                      isPassword: true,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _passwordFocus,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context)
                                              .requestFocus(_confirmFocus),
                                      validator: _validatePassword,
                                    ),
                                    const SizedBox(height: 14),

                                    // Confirm password
                                    CustomTextField(
                                      hint: 'Confirm password',
                                      prefixIcon: Icons.lock_rounded,
                                      controller: _confirmPasswordController,
                                      isPassword: true,
                                      textInputAction: TextInputAction.done,
                                      focusNode: _confirmFocus,
                                      onFieldSubmitted: (_) => _signup(),
                                      validator: _validateConfirm,
                                    ),

                                    const SizedBox(height: 18),

                                    // Terms checkbox
                                    GestureDetector(
                                      onTap: () => setState(
                                          () => _agreeToTerms = !_agreeToTerms),
                                      child: Row(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            width: 22,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: _agreeToTerms
                                                  ? theme.colorScheme.primary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color: _agreeToTerms
                                                    ? theme.colorScheme.primary
                                                    : isDark
                                                        ? Colors.white
                                                            .withOpacity(0.25)
                                                        : Colors.grey.shade300,
                                                width: 2,
                                              ),
                                            ),
                                            child: _agreeToTerms
                                                ? const Icon(
                                                    Icons.check_rounded,
                                                    color: Colors.white,
                                                    size: 14,
                                                  )
                                                : null,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'I agree to the ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: isDark
                                                      ? Colors.white
                                                          .withOpacity(0.55)
                                                      : const Color(0xFF888888),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Terms of Service',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' & ',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: isDark
                                                          ? Colors.white
                                                              .withOpacity(0.55)
                                                          : const Color(
                                                              0xFF888888),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: 'Privacy Policy',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    GradientButton(
                                      label: 'Create Account',
                                      onPressed: _signup,
                                      isLoading: _isLoading,
                                      gradientColors: const [
                                        Color(0xFFFF6584),
                                        Color(0xFF6C63FF),
                                      ],
                                      icon: Icons.person_add_rounded,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Sign in link
                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Already have an account? ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.white.withOpacity(0.55)
                                          : const Color(0xFF888888),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Sign In',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
