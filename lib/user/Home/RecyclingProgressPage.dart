import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:releaf_app/l10n/app_localizations.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

class RecyclingProgressPage extends StatefulWidget {
  const RecyclingProgressPage({super.key});

  @override
  State<RecyclingProgressPage> createState() => _RecyclingProgressPageState();
}

class _RecyclingProgressPageState extends State<RecyclingProgressPage>
    with SingleTickerProviderStateMixin {
  int recyclePoints = 0;
  int recycleLevel = 1;
  bool isLoadingStats = true;
  bool isAddingItems = false;
  bool showHistory = false;

  late AnimationController _plantAnimationController;
  late Animation<double> _plantScaleAnimation;

  Map<String, int> recycledItems = {};

  // Keys used for Firestore — always English
  final List<String> recycleKeys = [
    'Plastic',
    'Glass',
    'Paper',
    'Metal',
    'Cardboard',
    'Trash (non-recyclables)',
  ];

  final Map<String, int> selectedRecycleCounts = {
    'Plastic': 0,
    'Glass': 0,
    'Paper': 0,
    'Metal': 0,
    'Cardboard': 0,
    'Trash (non-recyclables)': 0,
  };

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _cardColor => _isDark ? const Color(0xFF1A2520) : Colors.white;
  Color get _innerCardColor =>
      _isDark ? const Color(0xFF101814) : ReLeafColors.background;
  Color get _softColor =>
      _isDark ? const Color(0xFF1F3028) : ReLeafColors.lightGreen;
  Color get _borderColor =>
      _isDark ? const Color(0xFF355246) : ReLeafColors.lightGreen;
  Color get _textColor => _isDark ? Colors.white : ReLeafColors.textDark;
  Color get _bodyColor => _isDark ? Colors.white70 : ReLeafColors.textMedium;

  String _translateKey(String key, AppLocalizations l) {
    switch (key) {
      case 'Plastic':
        return l.progressItemPlastic;
      case 'Glass':
        return l.progressItemGlass;
      case 'Paper':
        return l.progressItemPaper;
      case 'Metal':
        return l.progressItemMetal;
      case 'Cardboard':
        return l.progressItemCardboard;
      case 'Trash (non-recyclables)':
        return l.progressItemTrash;
      default:
        return key;
    }
  }

  @override
  void initState() {
    super.initState();

    _plantAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _plantScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.18,
    ).animate(
      CurvedAnimation(
        parent: _plantAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _loadRecyclingStats();
  }

  @override
  void dispose() {
    _plantAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadRecyclingStats() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        recyclePoints = 0;
        recycleLevel = 1;
        recycledItems = {};
        isLoadingStats = false;
      });
      return;
    }

    try {
      final scansSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('scans')
          .get();

      final Map<String, int> itemCounts = {};

      for (final doc in scansSnapshot.docs) {
        final data = doc.data();
        final itemName =
            (data['item'] ?? data['label'] ?? data['category'] ?? 'Unknown')
                .toString();

        itemCounts[itemName] = (itemCounts[itemName] ?? 0) + 1;
      }

      final totalItems =
          itemCounts.values.fold<int>(0, (sum, count) => sum + count);

      int level = (totalItems ~/ 50) + 1;
      if (level > 10) level = 10;

      if (!mounted) return;

      setState(() {
        recyclePoints = totalItems;
        recycleLevel = level;
        recycledItems = itemCounts;
        isLoadingStats = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        recyclePoints = 0;
        recycleLevel = 1;
        recycledItems = {};
        isLoadingStats = false;
      });
    }
  }

  Future<void> _addManualRecycledItems() async {
    final l = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final totalAdded =
        selectedRecycleCounts.values.fold<int>(0, (sum, count) => sum + count);

    if (totalAdded == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.progressSelectFirst)),
      );
      return;
    }

    if (user == null) return;

    setState(() => isAddingItems = true);

    try {
      final oldLevel = recycleLevel;
      final batch = FirebaseFirestore.instance.batch();

      selectedRecycleCounts.forEach((item, count) {
        for (int i = 0; i < count; i++) {
          final doc = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('scans')
              .doc();

          batch.set(doc, {
            'item': item,
            'source': 'manual',
            'points': 1,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      });

      await batch.commit();

      setState(() {
        selectedRecycleCounts.updateAll((key, value) => 0);
      });

      await _loadRecyclingStats();

      if (!mounted) return;

      if (recycleLevel > oldLevel) {
        _plantAnimationController.forward(from: 0);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.progressLevelUp)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.progressSuccess)),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.progressFailed)),
      );
    } finally {
      if (mounted) {
        setState(() => isAddingItems = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final sortedItems = recycledItems.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: l.progressTitle,
                subtitle: l.progressSubtitle,
                icon: Icons.eco_rounded,
                showBackButton: true,
                showNotifications: false,
                gradientColors: _isDark
                    ? const [
                        Color(0xFF1B3A31),
                        Color(0xFF2F5D50),
                      ]
                    : const [
                        Color(0xFF7FB77E),
                        Color(0xFF5E9C76),
                      ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainProgressCard(l),
                      const SizedBox(height: 20),
                      Text(
                        l.progressAddItems,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 22,
                          color: _textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: recycleKeys.map((key) {
                          return _buildRecycleCounterRow(key, l);
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ReLeafButton(
                          text: isAddingItems
                              ? l.progressAdding
                              : l.progressAddButton,
                          icon: isAddingItems
                              ? Icons.hourglass_top_rounded
                              : Icons.add_rounded,
                          onPressed:
                              isAddingItems ? null : _addManualRecycledItems,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l.progressMostRecycled,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 22,
                          color: _textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (isLoadingStats)
                        const Center(child: CircularProgressIndicator())
                      else if (sortedItems.isEmpty)
                        _buildEmptyInfoBox(l)
                      else
                        _buildRecycledItemsPodium(
                          sortedItems.take(3).toList(),
                          l,
                        ),
                      const SizedBox(height: 24),
                      _buildHistorySection(l),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainProgressCard(AppLocalizations l) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDark ? 0.28 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ScaleTransition(
            scale: _plantScaleAnimation,
            child: _buildPlantLevelIcon(recycleLevel),
          ),
          const SizedBox(height: 12),
          Text(
            l.progressLevel(recycleLevel),
            style: ReLeafTextStyles.title.copyWith(
              fontSize: 24,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getLevelMessage(recycleLevel, l),
            textAlign: TextAlign.center,
            style: ReLeafTextStyles.body.copyWith(
              fontSize: 15,
              color: _bodyColor,
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: _getLevelProgress(),
              minHeight: 12,
              backgroundColor: _softColor,
              color: ReLeafColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getNextLevelText(l),
            style: ReLeafTextStyles.subtitle.copyWith(
              fontSize: 13,
              color: _bodyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecycleCounterRow(String key, AppLocalizations l) {
    final count = selectedRecycleCounts[key] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            _getItemSvg(key),
            width: 26,
            height: 26,
            colorFilter: const ColorFilter.mode(
              ReLeafColors.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _translateKey(key, l),
              style: ReLeafTextStyles.title.copyWith(
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ),
          IconButton(
            onPressed: count == 0
                ? null
                : () {
                    setState(() {
                      selectedRecycleCounts[key] = count - 1;
                    });
                  },
            icon: const Icon(Icons.remove_circle_outline),
            color: ReLeafColors.primary,
          ),
          Text(
            '$count',
            style: ReLeafTextStyles.title.copyWith(
              fontSize: 16,
              color: _textColor,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedRecycleCounts[key] = count + 1;
              });
            },
            icon: const Icon(Icons.add_circle_outline),
            color: ReLeafColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyInfoBox(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.recycling_rounded, color: ReLeafColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.progressEmpty,
              style: ReLeafTextStyles.body.copyWith(
                color: _bodyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecycledItemsPodium(
    List<MapEntry<String, int>> topItems,
    AppLocalizations l,
  ) {
    final first = topItems.isNotEmpty ? topItems[0] : null;
    final second = topItems.length > 1 ? topItems[1] : null;
    final third = topItems.length > 2 ? topItems[2] : null;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDark ? 0.28 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        height: 285,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child:
                  _buildPodiumColumn(rank: 2, item: second, height: 115, l: l),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPodiumColumn(
                  rank: 1, item: first, height: 135, isWinner: true, l: l),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPodiumColumn(rank: 3, item: third, height: 90, l: l),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumColumn({
    required int rank,
    required MapEntry<String, int>? item,
    required double height,
    required AppLocalizations l,
    bool isWinner = false,
  }) {
    final itemKey = item?.key ?? '';
    final itemLabel = itemKey.isEmpty ? '—' : _translateKey(itemKey, l);
    final count = item?.value ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: isWinner ? 62 : 54,
          height: isWinner ? 62 : 54,
          decoration: BoxDecoration(
            color: _softColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: ReLeafColors.primary,
              width: isWinner ? 3 : 2,
            ),
          ),
          child: Center(
            child: SizedBox(
              width: isWinner ? 24 : 22,
              height: isWinner ? 24 : 22,
              child: SvgPicture.asset(
                _getItemSvg(itemKey),
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  ReLeafColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          itemLabel,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: ReLeafTextStyles.title.copyWith(
            fontSize: isWinner ? 14 : 13,
            color: _textColor,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _innerCardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _borderColor),
          ),
          child: Text(
            l.progressRecycledCount(count),
            style: ReLeafTextStyles.subtitle.copyWith(
              fontSize: 11,
              color: _bodyColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isWinner ? ReLeafColors.primary : _softColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: ReLeafTextStyles.title.copyWith(
                fontSize: 34,
                color: isWinner ? Colors.white : _textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(AppLocalizations l) {
    final historyItems = recycleKeys.map((key) {
      return MapEntry(key, recycledItems[key] ?? 0);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(_isDark ? 0.28 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showHistory = !showHistory;
              });
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: ReLeafColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l.progressViewHistory,
                    style: ReLeafTextStyles.title.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    showHistory
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
          if (showHistory) ...[
            const SizedBox(height: 18),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.45,
              children: historyItems.map((entry) {
                return _buildHistoryItemBox(entry.key, entry.value, l);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryItemBox(String key, int count, AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _innerCardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _getItemSvg(key),
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              ReLeafColors.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              _translateKey(key, l),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ReLeafTextStyles.title.copyWith(
                fontSize: 14,
                height: 1.1,
                color: _textColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l.progressRecycledCount(count),
            style: ReLeafTextStyles.body.copyWith(
              fontSize: 12,
              height: 1.1,
              color: _bodyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantLevelIcon(int level) {
    final icons = [
      Icons.grass_rounded,
      Icons.local_florist_rounded,
      Icons.eco_rounded,
      Icons.nature_rounded,
      Icons.park_rounded,
      Icons.forest_rounded,
      Icons.yard_rounded,
      Icons.energy_savings_leaf_rounded,
      Icons.spa_rounded,
      Icons.forest_rounded,
    ];

    final safeLevel = level.clamp(1, 10);
    final size = 100.0 + (safeLevel * 8);
    final iconSize = 48.0 + (safeLevel * 4);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _softColor,
        border: Border.all(
          color: ReLeafColors.primary,
          width: 3,
        ),
      ),
      child: Center(
        child: Icon(
          icons[safeLevel - 1],
          size: iconSize,
          color: ReLeafColors.primary,
        ),
      ),
    );
  }

  double _getLevelProgress() {
    if (recycleLevel == 10) return 1.0;

    final currentLevelStart = (recycleLevel - 1) * 50;
    final nextLevel = recycleLevel * 50;
    final progress =
        (recyclePoints - currentLevelStart) / (nextLevel - currentLevelStart);

    return progress.clamp(0.0, 1.0);
  }

  String _getNextLevelText(AppLocalizations l) {
    if (recycleLevel == 10) return l.progressMaxLevel;

    final nextLevelPoints = recycleLevel * 50;
    final remaining = nextLevelPoints - recyclePoints;

    return l.progressNextLevel(remaining, recycleLevel + 1);
  }

  String _getLevelMessage(int level, AppLocalizations l) {
    switch (level) {
      case 1:
        return l.progressMsg1;
      case 2:
        return l.progressMsg2;
      case 3:
        return l.progressMsg3;
      case 4:
        return l.progressMsg4;
      case 5:
        return l.progressMsg5;
      case 6:
        return l.progressMsg6;
      case 7:
        return l.progressMsg7;
      case 8:
        return l.progressMsg8;
      case 9:
        return l.progressMsg9;
      case 10:
        return l.progressMsg10;
      default:
        return l.progressMsgDefault;
    }
  }

  String _getItemSvg(String itemName) {
    final item = itemName.toLowerCase();

    if (item.contains('plastic')) return 'assets/icons/plastic.svg';
    if (item.contains('glass')) return 'assets/icons/glass.svg';
    if (item.contains('paper')) return 'assets/icons/paper.svg';
    if (item.contains('metal')) return 'assets/icons/metal.svg';
    if (item.contains('cardboard')) return 'assets/icons/cardboard.svg';
    if (item.contains('trash')) return 'assets/icons/trash.svg';

    return 'assets/icons/recycling.svg';
  }
}
