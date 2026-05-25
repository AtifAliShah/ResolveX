// lib/screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _contentController;
  late Animation<double> _contentOpacity;
  late Animation<Offset> _contentSlide;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      emoji: '🧠',
      title: 'Solve Real Life\nProblems Daily',
      subtitle:
          'Access science-backed solutions for the 10 most common daily life challenges — from stress to financial struggles.',
      gradient: [const Color(0xFF6C63FF), const Color(0xFF8E54E9)],
      backgroundColor: const Color(0xFF1A1535),
      illustrationEmojis: ['😰', '😴', '💸', '📱', '😤'],
    ),
    _OnboardingPage(
      emoji: '📚',
      title: 'Step-by-Step\nActionable Guides',
      subtitle:
          'No vague advice. Every solution is a clear, numbered action plan you can start executing in the next 5 minutes.',
      gradient: [const Color(0xFFFF6B9D), const Color(0xFFFF8E53)],
      backgroundColor: const Color(0xFF1A1020),
      illustrationEmojis: ['✅', '🎯', '📋', '⏱️', '🚀'],
    ),
    _OnboardingPage(
      emoji: '🔖',
      title: 'Save & Track\nYour Progress',
      subtitle:
          'Bookmark your favorite solutions, track how many you\'ve explored, and build momentum toward a better life.',
      gradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      backgroundColor: const Color(0xFF0A1A15),
      illustrationEmojis: ['💪', '📈', '🏆', '⭐', '🌱'],
    ),
    _OnboardingPage(
      emoji: '🌙',
      title: 'Light & Dark Mode\nFor Any Time',
      subtitle:
          'Comfortable in any lighting. Switch between beautiful light and dark themes that make reading a joy at any hour.',
      gradient: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      backgroundColor: const Color(0xFF0F0F1A),
      illustrationEmojis: ['☀️', '🌙', '✨', '🎨', '💫'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );
    _contentSlide =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _contentController, curve: Curves.easeOutCubic));
    _contentController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _contentController.forward(from: 0);
  }

  Future<void> _finish() async {
    await context.read<AppProvider>().setOnboardingSeen();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color: page.backgroundColor,
        ),
        child: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: page.gradient
                        .map((c) => c.withOpacity(0.15))
                        .toList(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: page.gradient
                        .map((c) => c.withOpacity(0.10))
                        .toList(),
                  ),
                ),
              ),
            ),

            // Skip button
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 20,
              child: GestureDetector(
                onTap: _finish,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return _buildPage(_pages[index], size);
              },
            ),

            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: MediaQuery.of(context).padding.bottom + 28,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Page indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: page.gradient.first,
                        dotColor: Colors.white.withOpacity(0.2),
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      ),
                    ),

                    // Next / Get Started button
                    GestureDetector(
                      onTap: _next,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: _currentPage == _pages.length - 1 ? 160 : 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: page.gradient,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: page.gradient.first.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: _currentPage == _pages.length - 1
                            ? Center(
                                child: Text(
                                  'Get Started',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page, Size size) {
    return AnimatedBuilder(
      animation: _contentController,
      builder: (context, child) {
        return SlideTransition(
          position: _contentSlide,
          child: Opacity(opacity: _contentOpacity.value, child: child),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 80,
          left: 28,
          right: 28,
          bottom: 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main emoji in glow container
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors:
                        page.gradient.map((c) => c.withOpacity(0.25)).toList(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: page.gradient.first.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    page.emoji,
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Floating emoji chips
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: page.illustrationEmojis.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.12), width: 1),
                    ),
                    child: Text(e, style: const TextStyle(fontSize: 20)),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 44),

            // Title
            Text(
              page.title,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 20),

            // Gradient divider
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: page.gradient),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 20),

            // Subtitle
            Text(
              page.subtitle,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.65),
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final Color backgroundColor;
  final List<String> illustrationEmojis;

  const _OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.backgroundColor,
    required this.illustrationEmojis,
  });
}
