import 'package:flutter/material.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool showHistory = false;

  late AnimationController _plantAnimationController;
  late Animation<double> _plantScaleAnimation;

  Map<String, int> recycledItems = {};

  final List<String> recycleOptions = [
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

      int level = 1;
      if (totalItems >= 200) {
        level = 5;
      } else if (totalItems >= 150) {
        level = 4;
      } else if (totalItems >= 100) {
        level = 3;
      } else if (totalItems >= 50) {
        level = 2;
      }

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
    final user = FirebaseAuth.instance.currentUser;
    final totalAdded =
        selectedRecycleCounts.values.fold<int>(0, (sum, count) => sum + count);

    if (user == null || totalAdded == 0) return;

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
          const SnackBar(
            content: Text('Level Up! Your plant grew! 🌱'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recycled items added successfully!'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not add recycled items. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedItems = recycledItems.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ReLeafHeader(
              title: 'Recycling Progress',
              subtitle: 'Grow your plant by recycling more!',
              icon: Icons.eco_rounded,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReLeafButton(
                      text: 'Back',
                      icon: Icons.arrow_back_rounded,
                      small: true,
                      onPressed: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: 18),

                    ReLeafCard(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          ScaleTransition(
                            scale: _plantScaleAnimation,
                            child: _buildPlantLevelIcon(recycleLevel),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Level $recycleLevel',
                            style:
                                ReLeafTextStyles.title.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getLevelMessage(recycleLevel),
                            textAlign: TextAlign.center,
                            style: ReLeafTextStyles.body.copyWith(fontSize: 15),
                          ),
                          const SizedBox(height: 18),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                              begin: 0,
                              end: _getLevelProgress(),
                            ),
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 12,
                                  backgroundColor: ReLeafColors.lightGreen,
                                  color: ReLeafColors.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getNextLevelText(),
                            style: ReLeafTextStyles.subtitle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Add Recycled Items',
                      style: ReLeafTextStyles.title.copyWith(fontSize: 22),
                    ),

                    const SizedBox(height: 12),

                    Column(
                      children: recycleOptions.map((item) {
                        return _buildRecycleCounterRow(item);
                      }).toList(),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ReLeafButton(
                        text: 'Add Items',
                        icon: Icons.add_rounded,
                        onPressed: _addManualRecycledItems,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Most Recycled Items',
                      style: ReLeafTextStyles.title.copyWith(fontSize: 22),
                    ),

                    const SizedBox(height: 12),

                    if (isLoadingStats)
                      const Center(child: CircularProgressIndicator())
                    else if (sortedItems.isEmpty)
                      const ReLeafInfoBox(
                        text:
                            'No recycled items yet. Add items above or scan from the Camera page.',
                        icon: Icons.recycling_rounded,
                      )
                    else
                        _buildRecycledItemsPodium(sortedItems.take(3).toList()),

                    const SizedBox(height: 24),

                      _buildHistorySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecycleCounterRow(String item) {
    final count = selectedRecycleCounts[item] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ReLeafColors.lightGreen),
      ),
      child: Row(
        children: [
          Icon(
            _getItemIcon(item),
            color: ReLeafColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item,
              style: ReLeafTextStyles.title.copyWith(fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: count == 0
                ? null
                : () {
                    setState(() {
                      selectedRecycleCounts[item] = count - 1;
                    });
                  },
            icon: const Icon(Icons.remove_circle_outline),
            color: ReLeafColors.primary,
          ),
          Text(
            '$count',
            style: ReLeafTextStyles.title.copyWith(fontSize: 16),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedRecycleCounts[item] = count + 1;
              });
            },
            icon: const Icon(Icons.add_circle_outline),
            color: ReLeafColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildRankedItemTile(int rank, String itemName, int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ReLeafColors.lightGreen),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ReLeafColors.lightGreen,
            child: Text(
              _rankText(rank),
              style: ReLeafTextStyles.title.copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            _getItemIcon(itemName),
            color: ReLeafColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              itemName,
              style: ReLeafTextStyles.title.copyWith(fontSize: 16),
            ),
          ),
          Text(
            '$count recycled',
            style: ReLeafTextStyles.body.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
  Widget _buildRecycledItemsPodium(List<MapEntry<String, int>> topItems) {
  final first = topItems.isNotEmpty ? topItems[0] : null;
  final second = topItems.length > 1 ? topItems[1] : null;
  final third = topItems.length > 2 ? topItems[2] : null;

  return ReLeafCard(
    padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
    child: SizedBox(
      height: 285,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _buildPodiumColumn(
              rank: 2,
              item: second,
              height: 115,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildPodiumColumn(
              rank: 1,
              item: first,
              height: 135,
              isWinner: true,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildPodiumColumn(
              rank: 3,
              item: third,
              height: 90,
            ),
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
  bool isWinner = false,
}) {
  final itemName = item?.key ?? 'No item';
  final count = item?.value ?? 0;

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: isWinner ? 62 : 54,
        height: isWinner ? 62 : 54,
        decoration: BoxDecoration(
          color: ReLeafColors.lightGreen,
          shape: BoxShape.circle,
          border: Border.all(
            color: ReLeafColors.primary,
            width: isWinner ? 3 : 2,
          ),
        ),
        child: Icon(
          _getItemIcon(itemName),
          color: ReLeafColors.primary,
          size: isWinner ? 32 : 28,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        itemName,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: ReLeafTextStyles.title.copyWith(
          fontSize: isWinner ? 14 : 13,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ReLeafColors.lightGreen),
        ),
        child: Text(
          '$count recycled',
          style: ReLeafTextStyles.subtitle.copyWith(
            fontSize: 11,
            color: ReLeafColors.textDark,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isWinner ? ReLeafColors.primary : ReLeafColors.lightGreen,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Center(
          child: Text(
            '$rank',
            style: ReLeafTextStyles.title.copyWith(
              fontSize: 34,
              color: isWinner ? Colors.white : ReLeafColors.textDark,
            ),
          ),
        ),
      ),
    ],
  );
}
Widget _buildHistorySection() {
  final historyItems = recycleOptions.map((item) {
    return MapEntry(item, recycledItems[item] ?? 0);
  }).toList();

  return ReLeafCard(
    padding: const EdgeInsets.all(16),
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
                  'View History',
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
            childAspectRatio: 1.15,
            children: historyItems.map((entry) {
              return _buildHistoryItemBox(entry.key, entry.value);
            }).toList(),
          ),
        ],
      ],
    ),
  );
}

Widget _buildHistoryItemBox(String itemName, int count) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: ReLeafColors.background,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: ReLeafColors.lightGreen),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          _getItemIcon(itemName),
          color: ReLeafColors.primary,
          size: 32,
        ),
        const SizedBox(height: 10),
        Text(
          itemName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: ReLeafTextStyles.title.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 6),
        Text(
          '$count recycled',
          style: ReLeafTextStyles.body.copyWith(fontSize: 13),
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
      Icons.park_rounded,
      Icons.forest_rounded,
    ];

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ReLeafColors.lightGreen,
        border: Border.all(
          color: ReLeafColors.primary,
          width: 3,
        ),
      ),
      child: Center(
        child: Icon(
          icons[level - 1],
          size: 64,
          color: ReLeafColors.primary,
        ),
      ),
    );
  }

  double _getLevelProgress() {
    if (recycleLevel == 5) return 1.0;

    final currentLevelStart = (recycleLevel - 1) * 50;
    final nextLevel = recycleLevel * 50;
    final progress =
        (recyclePoints - currentLevelStart) / (nextLevel - currentLevelStart);

    return progress.clamp(0.0, 1.0);
  }

  String _getNextLevelText() {
    if (recycleLevel == 5) {
      return 'You reached the highest level. Keep recycling!';
    }

    final nextLevelPoints = recycleLevel * 50;
    final remaining = nextLevelPoints - recyclePoints;

    return '$remaining more recycled items needed for Level ${recycleLevel + 1}';
  }

  String _getLevelMessage(int level) {
    switch (level) {
      case 1:
        return 'A small seed has started growing.';
      case 2:
        return 'Your plant is sprouting.';
      case 3:
        return 'Your eco habit is growing stronger.';
      case 4:
        return 'Your plant is becoming a healthy tree.';
      case 5:
        return 'You are a ReLeaf recycling champion!';
      default:
        return 'Keep recycling to grow your plant.';
    }
  }

  IconData _getItemIcon(String itemName) {
    final item = itemName.toLowerCase();

    if (item.contains('plastic')) return Icons.local_drink_rounded;
    if (item.contains('glass')) return Icons.wine_bar_rounded;
    if (item.contains('paper')) return Icons.description_rounded;
    if (item.contains('metal')) return Icons.inventory_2_rounded;
    if (item.contains('cardboard')) return Icons.archive_rounded;
    if (item.contains('trash')) return Icons.delete_outline_rounded;
    return Icons.recycling_rounded;
  }

  String _rankText(int rank) {
    if (rank == 1) return '1st';
    if (rank == 2) return '2nd';
    if (rank == 3) return '3rd';
    return '${rank}th';
  }
}