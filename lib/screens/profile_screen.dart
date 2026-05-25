// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showLogoutDialog(BuildContext context, AppProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).padding.bottom + 24,
          ),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF3A3A5E)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6584).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded,
                    color: Color(0xFFFF6584), size: 30),
              ),
              const SizedBox(height: 16),
              Text(
                'Sign Out?',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your saved solutions and progress are safely stored locally and will be waiting when you return.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark
                      ? const Color(0xFF888899)
                      : const Color(0xFF888888),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2A2A3E)
                              : const Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Stay',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(ctx).pop();
                        await provider.logout();
                        if (context.mounted) {
                          Navigator.of(context)
                              .pushReplacementNamed('/login');
                        }
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6584), Color(0xFFFF3B60)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF6584).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Sign Out',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F2F5),
      body: Consumer2<AppProvider, ThemeProvider>(
        builder: (context, appProvider, themeProvider, _) {
          return CustomScrollView(
            slivers: [
              // ─── Header ────────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _ProfileHeader(
                    name: appProvider.userName,
                    email: appProvider.userEmail,
                    isDark: isDark,
                  ),
                ),
              ),

              // ─── Stats Cards ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 14),
                            child: SectionHeader(title: '📊 Your Stats'),
                          ),
                          Row(
                            children: [
                              StatsCard(
                                value:
                                    appProvider.totalViewed.toString(),
                                label: 'Solutions\nViewed',
                                icon: Icons.visibility_rounded,
                                colors: const [
                                  Color(0xFF6C63FF),
                                  Color(0xFF8E54E9)
                                ],
                              ),
                              const SizedBox(width: 12),
                              StatsCard(
                                value:
                                    appProvider.favoritesCount.toString(),
                                label: 'Solutions\nSaved',
                                icon: Icons.bookmark_rounded,
                                colors: const [
                                  Color(0xFFFF6B9D),
                                  Color(0xFFFF8E53)
                                ],
                              ),
                              const SizedBox(width: 12),
                              StatsCard(
                                value:
                                    appProvider.categories.length.toString(),
                                label: 'Categories\nAvailable',
                                icon: Icons.category_rounded,
                                colors: const [
                                  Color(0xFF11998E),
                                  Color(0xFF38EF7D)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ─── Settings ─────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 14),
                            child: SectionHeader(title: '⚙️ Preferences'),
                          ),

                          // Theme toggle
                          _SettingsCard(
                            isDark: isDark,
                            child: _ThemeToggleRow(
                              isDark: isDark,
                              themeProvider: themeProvider,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Notification setting
                          _SettingsCard(
                            isDark: isDark,
                            child: _SettingsRow(
                              icon: Icons.notifications_none_rounded,
                              iconColor: const Color(0xFFFF6584),
                              title: 'Daily Reminders',
                              subtitle: 'Get nudged to solve one problem daily',
                              isDark: isDark,
                              trailing: Switch.adaptive(
                                value: true,
                                onChanged: (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '🔔 Notification settings coming soon!',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13),
                                      ),
                                      backgroundColor:
                                          const Color(0xFFFF6584),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                },
                                activeColor: const Color(0xFFFF6584),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          const Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 14),
                            child: SectionHeader(title: '🔗 About'),
                          ),

                          _SettingsCard(
                            isDark: isDark,
                            child: Column(
                              children: [
                                _SettingsRow(
                                  icon: Icons.info_outline_rounded,
                                  iconColor: const Color(0xFF6C63FF),
                                  title: 'App Version',
                                  subtitle: 'ResolveX v1.0.0 (Production)',
                                  isDark: isDark,
                                  trailing: null,
                                ),
                                _Divider(isDark: isDark),
                                _TappableSettingsRow(
                                  icon: Icons.star_outline_rounded,
                                  iconColor: const Color(0xFFF9D423),
                                  title: 'Rate ResolveX',
                                  subtitle: 'Love the app? Give us 5 stars!',
                                  isDark: isDark,
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '⭐ Opening App Store... (Demo)',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13),
                                        ),
                                        backgroundColor:
                                            const Color(0xFFF9D423),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                _Divider(isDark: isDark),
                                _TappableSettingsRow(
                                  icon: Icons.share_outlined,
                                  iconColor: const Color(0xFF43C6AC),
                                  title: 'Share ResolveX',
                                  subtitle:
                                      'Help others discover better solutions',
                                  isDark: isDark,
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '📤 Share sheet opened (Demo)',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13),
                                        ),
                                        backgroundColor:
                                            const Color(0xFF43C6AC),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                _Divider(isDark: isDark),
                                _TappableSettingsRow(
                                  icon: Icons.privacy_tip_outlined,
                                  iconColor: const Color(0xFF667EEA),
                                  title: 'Privacy Policy',
                                  subtitle: 'How we protect your data',
                                  isDark: isDark,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Logout Button
                          GestureDetector(
                            onTap: () =>
                                _showLogoutDialog(context, appProvider),
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6584).withOpacity(
                                    isDark ? 0.12 : 0.08),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFFF6584)
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.logout_rounded,
                                      color: Color(0xFFFF6584), size: 22),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Sign Out',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF6584),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Footer text
                          Center(
                            child: Text(
                              'Made with ❤️ by ResolveX Team\n© 2025 All Rights Reserved',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: isDark
                                    ? const Color(0xFF444455)
                                    : const Color(0xFFCCCCCC),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Profile Header ───────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isDark;

  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8E54E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              name.isNotEmpty ? name : 'Explorer',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email.isNotEmpty ? email : 'Not signed in',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withOpacity(0.75),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_rounded,
                      color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Premium Problem Solver',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Settings Card Container ──────────────────────────────────────────────────
class _SettingsCard extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const _SettingsCard({required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─── Settings Row ─────────────────────────────────────────────────────────────
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isDark;
  final Widget? trailing;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:
                        isDark ? const Color(0xFFE8E8F0) : const Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: isDark
                        ? const Color(0xFF888899)
                        : const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// ─── Tappable Settings Row ────────────────────────────────────────────────────
class _TappableSettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isDark;
  final VoidCallback onTap;

  const _TappableSettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xFFE8E8F0)
                          : const Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: isDark
                          ? const Color(0xFF888899)
                          : const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isDark ? const Color(0xFF444455) : const Color(0xFFCCCCCC),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Theme Toggle Row ─────────────────────────────────────────────────────────
class _ThemeToggleRow extends StatelessWidget {
  final bool isDark;
  final ThemeProvider themeProvider;

  const _ThemeToggleRow({required this.isDark, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF6C63FF).withOpacity(0.15)
                  : const Color(0xFFF9D423).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                key: ValueKey(isDark),
                color: isDark ? const Color(0xFF6C63FF) : const Color(0xFFF9D423),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDark ? 'Dark Mode' : 'Light Mode',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFFE8E8F0)
                        : const Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  isDark
                      ? 'Switch to light for daytime use'
                      : 'Switch to dark for night-time use',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: isDark
                        ? const Color(0xFF888899)
                        : const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
            activeColor: const Color(0xFF6C63FF),
          ),
        ],
      ),
    );
  }
}

// ─── Divider ─────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  final bool isDark;

  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 70,
      endIndent: 0,
      color: isDark
          ? Colors.white.withOpacity(0.05)
          : Colors.black.withOpacity(0.04),
    );
  }
}
