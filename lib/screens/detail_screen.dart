// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/problem_model.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_widgets.dart';

class DetailScreen extends StatefulWidget {
  final Problem problem;

  const DetailScreen({super.key, required this.problem});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;
  late Animation<double> _headerOpacity;
  late Animation<double> _contentOpacity;
  late Animation<Offset> _contentSlide;

  late List<bool> _stepCompleted;
  int _completedSteps = 0;

  @override
  void initState() {
    super.initState();
    _stepCompleted = List.filled(widget.problem.steps.length, false);

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _headerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeIn),
    );
    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeIn),
    );
    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController, curve: Curves.easeOutCubic),
    );

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _contentController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _toggleStep(int index) {
    setState(() {
      _stepCompleted[index] = !_stepCompleted[index];
      _completedSteps =
          _stepCompleted.where((s) => s).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = hexListToColors(widget.problem.gradientColors);

    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final isFav = provider.isFavorite(widget.problem.id);
        final progress =
            widget.problem.steps.isEmpty
                ? 0.0
                : _completedSteps / widget.problem.steps.length;

        return Scaffold(
          backgroundColor:
              isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F2F5),
          body: CustomScrollView(
            slivers: [
              // ─── Hero Header ───────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: colors.first,
                leading: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => provider.toggleFavorite(widget.problem),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          isFav
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          key: ValueKey(isFav),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: FadeTransition(
                    opacity: _headerOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Decorative circles
                          Positioned(
                            top: -40,
                            right: -40,
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: -30,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.06),
                              ),
                            ),
                          ),

                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Category chip
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.problem.categoryEmoji,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.problem.categoryTitle,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Title
                                  Text(
                                    widget.problem.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Progress bar
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Progress',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            '$_completedSteps/${widget.problem.steps.length} steps',
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.2),
                                          valueColor:
                                              const AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ─── Content ───────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: SlideTransition(
                  position: _contentSlide,
                  child: FadeTransition(
                    opacity: _contentOpacity,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Short description
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E1E2E)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(isDark ? 0.2 : 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: colors),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.info_outline_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Overview',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? const Color(0xFFE8E8F0)
                                            : const Color(0xFF1A1A2E),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  widget.problem.fullDescription,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isDark
                                        ? const Color(0xFFBBBBCC)
                                        : const Color(0xFF555555),
                                    height: 1.75,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Steps section
                          _SectionTitle(
                            title: '📋 Step-by-Step Action Plan',
                            subtitle: 'Tap each step to mark complete',
                            colors: colors,
                          ),

                          const SizedBox(height: 14),

                          ...List.generate(widget.problem.steps.length, (i) {
                            return _StepCard(
                              index: i,
                              text: widget.problem.steps[i],
                              isCompleted: _stepCompleted[i],
                              onTap: () => _toggleStep(i),
                              colors: colors,
                              isDark: isDark,
                            );
                          }),

                          const SizedBox(height: 24),

                          // Completion celebration
                          if (_completedSteps == widget.problem.steps.length)
                            _CompletionCard(
                              colors: colors,
                              isDark: isDark,
                              problemTitle: widget.problem.title,
                            ),

                          if (_completedSteps == widget.problem.steps.length)
                            const SizedBox(height: 24),

                          // Tips section
                          _SectionTitle(
                            title: '💡 Expert Tips & Insights',
                            subtitle: 'Science-backed wisdom to maximize results',
                            colors: colors,
                          ),

                          const SizedBox(height: 14),

                          ...List.generate(widget.problem.tips.length, (i) {
                            return _TipCard(
                              text: widget.problem.tips[i],
                              index: i,
                              colors: colors,
                              isDark: isDark,
                            );
                          }),

                          const SizedBox(height: 24),

                          // Motivational quote card
                          _MotivationCard(colors: colors, isDark: isDark),

                          const SizedBox(height: 24),

                          // Save button
                          GradientButton(
                            label: isFav
                                ? '✓ Saved to Bookmarks'
                                : '🔖 Save This Solution',
                            onPressed: () =>
                                provider.toggleFavorite(widget.problem),
                            gradientColors: isFav
                                ? [
                                    const Color(0xFF11998E),
                                    const Color(0xFF38EF7D),
                                  ]
                                : colors,
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
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

// ─── Section Title Widget ─────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> colors;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? const Color(0xFFE8E8F0) : const Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isDark ? const Color(0xFF888899) : const Color(0xFF888888),
          ),
        ),
      ],
    );
  }
}

// ─── Step Card ─────────────────────────────────────────────────────────────────
class _StepCard extends StatelessWidget {
  final int index;
  final String text;
  final bool isCompleted;
  final VoidCallback onTap;
  final List<Color> colors;
  final bool isDark;

  const _StepCard({
    required this.index,
    required this.text,
    required this.isCompleted,
    required this.onTap,
    required this.colors,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted
              ? colors.first.withOpacity(isDark ? 0.15 : 0.08)
              : isDark
                  ? const Color(0xFF1E1E2E)
                  : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? colors.first.withOpacity(0.4)
                : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: isCompleted
                    ? LinearGradient(colors: colors)
                    : null,
                color: isCompleted
                    ? null
                    : isDark
                        ? const Color(0xFF2A2A3E)
                        : const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 18)
                    : Text(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: colors.first,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.6,
                  color: isCompleted
                      ? (isDark
                          ? const Color(0xFF888899)
                          : const Color(0xFFAAAAAA))
                      : (isDark
                          ? const Color(0xFFCCCCDD)
                          : const Color(0xFF333333)),
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tip Card ─────────────────────────────────────────────────────────────────
class _TipCard extends StatelessWidget {
  final String text;
  final int index;
  final List<Color> colors;
  final bool isDark;

  const _TipCard({
    required this.text,
    required this.index,
    required this.colors,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.65,
                color: isDark
                    ? const Color(0xFFBBBBCC)
                    : const Color(0xFF444444),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Completion Card ──────────────────────────────────────────────────────────
class _CompletionCard extends StatefulWidget {
  final List<Color> colors;
  final bool isDark;
  final String problemTitle;

  const _CompletionCard({
    required this.colors,
    required this.isDark,
    required this.problemTitle,
  });

  @override
  State<_CompletionCard> createState() => _CompletionCardState();
}

class _CompletionCardState extends State<_CompletionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.colors.first.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'All Steps Completed!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You\'ve conquered "${widget.problemTitle}". Keep the momentum going! 🚀',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Motivation Card ──────────────────────────────────────────────────────────
class _MotivationCard extends StatelessWidget {
  final List<Color> colors;
  final bool isDark;

  const _MotivationCard({required this.colors, required this.isDark});

  static const List<Map<String, String>> _quotes = [
    {
      'quote': 'The secret of getting ahead is getting started.',
      'author': '— Mark Twain',
    },
    {
      'quote': 'You don\'t have to be great to start, but you have to start to be great.',
      'author': '— Zig Ziglar',
    },
    {
      'quote': 'Small steps in the right direction are better than big steps in the wrong direction.',
      'author': '— Unknown',
    },
    {
      'quote': 'Motivation is what gets you started. Habit is what keeps you going.',
      'author': '— Jim Ryun',
    },
    {
      'quote': 'Progress, not perfection, is the goal.',
      'author': '— Unknown',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final quoteIndex = DateTime.now().day % _quotes.length;
    final quote = _quotes[quoteIndex];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.first.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.15 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: colors,
                ).createShader(bounds),
                child: const Text(
                  '✨',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Daily Motivation',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colors.first,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '"${quote['quote']!}"',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: isDark ? const Color(0xFFCCCCDD) : const Color(0xFF333333),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            quote['author']!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.first,
            ),
          ),
        ],
      ),
    );
  }
}
