// lib/screens/home_screen.dart
// =========================================================================
// File: home_screen.dart / detail_screen.dart
// Domain: Presentation Layer (User Interface)
// Description: Renders the highly interactive, responsive, and visually modern UI layouts.
//              Listens directly to application providers to update views seamlessly.
// Layout Aesthetics: Ultra-modern enhanced dashboard interface styling
// =========================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/problem_model.dart';
import '../widgets/custom_widgets.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _openDetail(BuildContext context, Problem problem) {
    context.read<AppProvider>().incrementViewed();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailScreen(problem: problem),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _openCategoryProblems(
      BuildContext context, ProblemCategory category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _CategoryProblemsScreen(category: category),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F0F1A)
          : const Color(0xFFF0F2F5),
      body: Consumer<AppProvider>(
        builder: (context, provider, _) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ─── Sliver App Bar ────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 180,
                pinned: true,
                backgroundColor:
                    isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F2F5),
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                const Color(0xFF0F0F1A),
                                const Color(0xFF1A1535),
                              ]
                            : [
                                const Color(0xFFF0F2F5),
                                const Color(0xFFEAE8FF),
                              ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getGreeting(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: isDark
                                            ? Colors.white.withOpacity(0.5)
                                            : const Color(0xFF888888),
                                      ),
                                    ),
                                    Text(
                                      provider.userName.isNotEmpty
                                          ? provider.userName
                                          : 'Explorer 👋',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF1A1A2E),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 46,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6C63FF),
                                        Color(0xFFFF6584)
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6C63FF)
                                            .withOpacity(0.35),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      provider.userName.isNotEmpty
                                          ? provider.userName[0].toUpperCase()
                                          : '?',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: AppSearchBar(
                      controller: _searchController,
                      hint: 'Search problems, solutions...',
                      onChanged: (query) {
                        provider.search(query);
                        setState(() {});
                      },
                      onClear: () {
                        provider.clearSearch();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),

              // ─── Search Results ────────────────────────────────────────────
              if (provider.isSearching) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: SectionHeader(
                      title: '${provider.searchResults.length} Results',
                    ),
                  ),
                ),
                if (provider.searchResults.isEmpty)
                  SliverToBoxAdapter(
                    child: EmptyStateWidget(
                      emoji: '🔍',
                      title: 'No results found',
                      subtitle:
                          'Try searching with different keywords like "stress", "sleep", or "focus"',
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final problem = provider.searchResults[index];
                          return _AnimatedListItem(
                            index: index,
                            child: ProblemListTile(
                              emoji: problem.categoryEmoji,
                              title: problem.title,
                              subtitle: problem.categoryTitle,
                              colors: hexListToColors(problem.gradientColors),
                              isFavorite: provider.isFavorite(problem.id),
                              onTap: () => _openDetail(context, problem),
                              onFavoriteTap: () =>
                                  provider.toggleFavorite(problem),
                            ),
                          );
                        },
                        childCount: provider.searchResults.length,
                      ),
                    ),
                  ),
              ]

              // ─── Normal Home Content ───────────────────────────────────────
              else ...[
                // Quick stats banner
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _QuickStatsBanner(provider: provider),
                  ),
                ),

                // Categories header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                    child: SectionHeader(
                      title: '10 Problem Categories',
                    ),
                  ),
                ),

                // Categories grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.88,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = provider.categories[index];
                        return _AnimatedGridItem(
                          index: index,
                          child: GradientCategoryCard(
                            emoji: category.emoji,
                            title: category.title,
                            description: category.description,
                            colors: hexListToColors(category.gradientColors),
                            problemCount: category.problems.length,
                            onTap: () =>
                                _openCategoryProblems(context, category),
                          ),
                        );
                      },
                      childCount: provider.categories.length,
                    ),
                  ),
                ),

                // Featured problems header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
                    child: SectionHeader(
                      title: '🔥 Featured Solutions',
                    ),
                  ),
                ),

                // Featured problems list (first problem from each category)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = provider.categories[index];
                        if (category.problems.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        final problem = category.problems[0];
                        return _AnimatedListItem(
                          index: index,
                          child: ProblemListTile(
                            emoji: problem.categoryEmoji,
                            title: problem.title,
                            subtitle: problem.categoryTitle,
                            colors: hexListToColors(problem.gradientColors),
                            isFavorite: provider.isFavorite(problem.id),
                            onTap: () => _openDetail(context, problem),
                            onFavoriteTap: () =>
                                provider.toggleFavorite(problem),
                          ),
                        );
                      },
                      childCount: provider.categories.length,
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }
}

// ─── Quick Stats Banner ───────────────────────────────────────────────────────
class _QuickStatsBanner extends StatelessWidget {
  final AppProvider provider;

  const _QuickStatsBanner({required this.provider});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8E54E9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎯 ${provider.categories.length * 2} Solutions Ready',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Viewed: ${provider.totalViewed} · Saved: ${provider.favoritesCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '10 Topics',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated Grid Item ───────────────────────────────────────────────────────
class _AnimatedGridItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedGridItem({required this.index, required this.child});

  @override
  State<_AnimatedGridItem> createState() => _AnimatedGridItemState();
}

class _AnimatedGridItemState extends State<_AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400 + widget.index * 60),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 60), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(opacity: _opacity, child: widget.child),
    );
  }
}

// ─── Animated List Item ───────────────────────────────────────────────────────
class _AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedListItem({required this.index, required this.child});

  @override
  State<_AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<_AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400 + widget.index * 50),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(opacity: _opacity, child: widget.child),
    );
  }
}

// ─── Category Problems Screen ─────────────────────────────────────────────────
class _CategoryProblemsScreen extends StatelessWidget {
  final ProblemCategory category;

  const _CategoryProblemsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = hexListToColors(category.gradientColors);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: colors.first,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white, size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(category.emoji,
                          style: const TextStyle(fontSize: 56)),
                      const SizedBox(height: 8),
                      Text(
                        category.title,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${category.problems.length} solutions available',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: Consumer<AppProvider>(
              builder: (context, provider, _) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final problem = category.problems[index];
                      return _AnimatedListItem(
                        index: index,
                        child: ProblemListTile(
                          emoji: problem.categoryEmoji,
                          title: problem.title,
                          subtitle: problem.shortDescription,
                          colors: hexListToColors(problem.gradientColors),
                          isFavorite: provider.isFavorite(problem.id),
                          onTap: () {
                            provider.incrementViewed();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(problem: problem),
                              ),
                            );
                          },
                          onFavoriteTap: () =>
                              provider.toggleFavorite(problem),
                        ),
                      );
                    },
                    childCount: category.problems.length,
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}
