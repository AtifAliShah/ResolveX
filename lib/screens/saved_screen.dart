// lib/screens/saved_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/problem_model.dart';
import '../widgets/custom_widgets.dart';
import 'detail_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation(BuildContext context, Problem problem,
      AppProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DeleteBottomSheet(
        problem: problem,
        onConfirm: () {
          provider.removeFavorite(problem.id);
          Navigator.of(ctx).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🗑️ "${problem.title}" removed from saved',
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              backgroundColor: const Color(0xFFFF6584),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Colors.white,
                onPressed: () => provider.toggleFavorite(problem),
              ),
            ),
          );
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void _clearAllSaved(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        title: Text(
          'Clear All Saved?',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This will remove all ${provider.favoritesCount} saved solutions. This action cannot be undone.',
          style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final problems = List.from(provider.favoriteProblems);
              for (final p in problems) {
                provider.removeFavorite(p.id);
              }
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '🗑️ All saved solutions cleared',
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  backgroundColor: const Color(0xFFFF6584),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: Text(
              'Clear All',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF6584),
              ),
            ),
          ),
        ],
      ),
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
      body: Consumer<AppProvider>(
        builder: (context, provider, _) {
          final favorites = provider.favoriteProblems;

          return CustomScrollView(
            slivers: [
              // ─── App Bar ───────────────────────────────────────────────────
              SliverAppBar(
                pinned: true,
                backgroundColor: isDark
                    ? const Color(0xFF0F0F1A)
                    : const Color(0xFFF0F2F5),
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                title: Column(
                  children: [
                    Text(
                      'Saved Solutions',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                      ),
                    ),
                    if (favorites.isNotEmpty)
                      Text(
                        '${favorites.length} solution${favorites.length == 1 ? '' : 's'} bookmarked',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDark
                              ? const Color(0xFF888899)
                              : const Color(0xFF888888),
                        ),
                      ),
                  ],
                ),
                actions: [
                  if (favorites.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.delete_sweep_rounded,
                        color: const Color(0xFFFF6584).withOpacity(0.8),
                        size: 26,
                      ),
                      onPressed: () => _clearAllSaved(context, provider),
                    ),
                ],
              ),

              // ─── Content ───────────────────────────────────────────────────
              if (favorites.isEmpty)
                SliverFillRemaining(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: EmptyStateWidget(
                      emoji: '🔖',
                      title: 'No Saved Solutions Yet',
                      subtitle:
                          'Browse through the categories and tap the bookmark icon to save solutions for quick access.',
                      buttonLabel: 'Explore Solutions',
                      onButtonPressed: () {
                        // Signal main layout to switch to Home tab
                        Navigator.of(context)
                            .pushReplacementNamed('/main');
                      },
                    ),
                  ),
                )
              else ...[
                // Stats row
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: _SavedStatsRow(
                        count: favorites.length,
                        categories: favorites
                            .map((p) => p.categoryTitle)
                            .toSet()
                            .length,
                        isDark: isDark,
                      ),
                    ),
                  ),
                ),

                // Section header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                    child: SectionHeader(title: 'Your Bookmarks'),
                  ),
                ),

                // List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final problem = favorites[index];
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: Dismissible(
                            key: Key(problem.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              provider.removeFavorite(problem.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '🗑️ "${problem.title}" removed',
                                    style: GoogleFonts.poppins(fontSize: 13),
                                  ),
                                  backgroundColor: const Color(0xFFFF6584),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Colors.white,
                                    onPressed: () =>
                                        provider.toggleFavorite(problem),
                                  ),
                                ),
                              );
                            },
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6584),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.delete_outline_rounded,
                                      color: Colors.white, size: 28),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Delete',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            child: _SavedProblemCard(
                              problem: problem,
                              isDark: isDark,
                              onTap: () {
                                provider.incrementViewed();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailScreen(problem: problem),
                                  ),
                                );
                              },
                              onDelete: () => _showDeleteConfirmation(
                                  context, problem, provider),
                            ),
                          ),
                        );
                      },
                      childCount: favorites.length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ],
          );
        },
      ),
    );
  }
}

// ─── Saved Stats Row ──────────────────────────────────────────────────────────
class _SavedStatsRow extends StatelessWidget {
  final int count;
  final int categories;
  final bool isDark;

  const _SavedStatsRow({
    required this.count,
    required this.categories,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          icon: Icons.bookmark_rounded,
          label: '$count Saved',
          color: const Color(0xFF6C63FF),
          isDark: isDark,
        ),
        const SizedBox(width: 10),
        _StatChip(
          icon: Icons.category_rounded,
          label: '$categories Categories',
          color: const Color(0xFFFF6584),
          isDark: isDark,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Saved Problem Card ───────────────────────────────────────────────────────
class _SavedProblemCard extends StatelessWidget {
  final Problem problem;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _SavedProblemCard({
    required this.problem,
    required this.isDark,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = hexListToColors(problem.gradientColors);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  problem.categoryEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    problem.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? const Color(0xFFE8E8F0)
                          : const Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: colors.first.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          problem.categoryTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: colors.first,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${problem.steps.length} steps',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: isDark
                              ? const Color(0xFF888899)
                              : const Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6584).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFFF6584),
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark
                      ? const Color(0xFF555570)
                      : const Color(0xFFCCCCCC),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Delete Bottom Sheet ──────────────────────────────────────────────────────
class _DeleteBottomSheet extends StatelessWidget {
  final Problem problem;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _DeleteBottomSheet({
    required this.problem,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = hexListToColors(problem.gradientColors);

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
              color: isDark ? const Color(0xFF3A3A5E) : Colors.grey.shade200,
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
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Color(0xFFFF6584),
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Remove Saved Solution?',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"${problem.title}"',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: colors.first,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'You can always re-save this solution from the home screen.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: isDark ? const Color(0xFF888899) : const Color(0xFF888888),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onCancel,
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
                        'Keep It',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onConfirm,
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
                        'Remove',
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
  }
}
