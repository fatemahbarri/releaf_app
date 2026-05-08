import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';
import '../../widgets/admin_background.dart';

class AdminReportIssue extends StatefulWidget {
  final String? selectedIssueId;

  const AdminReportIssue({
    super.key,
    this.selectedIssueId,
  });

  @override
  State<AdminReportIssue> createState() => _AdminReportIssueState();
}

class _AdminReportIssueState extends State<AdminReportIssue> {
  String _selectedFilter = 'All';
  late String? _expandedIssueId;

  final Map<String, TextEditingController> _commentControllers = {};
  final Map<String, bool> _fixedValues = {};

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);

  @override
  void initState() {
    super.initState();
    _expandedIssueId = widget.selectedIssueId;
  }

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get cardBg => isDark ? const Color(0xFF1F2D28) : Colors.white;
  Color get inputBg =>
      isDark ? const Color(0xFF17211C) : const Color(0xFFF7FBF2);
  Color get chipBg => isDark ? const Color(0xFF263A32) : Colors.white;
  Color get iconBoxBg => isDark ? const Color(0xFF31443B) : lightGreen;
  Color get borderColor => isDark ? Colors.white10 : border;
  Color get titleColor => isDark ? Colors.white : textDark;
  Color get subTextColor => isDark ? Colors.white70 : textMedium;
  Color get hintColor => isDark ? Colors.white54 : textMedium;
  Color get topBarStart => isDark ? const Color(0xFF1F2D28) : primary;
  Color get topBarEnd => isDark ? const Color(0xFF31443B) : secondary;

  Stream<QuerySnapshot<Map<String, dynamic>>> _getIssuesStream() {
    return FirebaseFirestore.instance
        .collection('issues')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null || timestamp is! Timestamp) return '';

    final date = timestamp.toDate();

    return '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getStatus(Map<String, dynamic> issue) {
    return (issue['status'] ?? 'unread').toString().toLowerCase();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterIssues(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> issues,
  ) {
    if (_selectedFilter == 'All') return issues;

    final selected = _selectedFilter.toLowerCase();

    return issues.where((doc) {
      final status = _getStatus(doc.data());
      return status == selected;
    }).toList();
  }

  Future<void> _openIssue(
    String issueId,
    Map<String, dynamic> issue,
  ) async {
    final status = _getStatus(issue);

    setState(() {
      _expandedIssueId = _expandedIssueId == issueId ? null : issueId;

      _commentControllers.putIfAbsent(
        issueId,
        () => TextEditingController(
          text: issue['adminComment'] ?? '',
        ),
      );

      _fixedValues[issueId] = status == 'fixed';
    });

    if (status == 'unread') {
      await FirebaseFirestore.instance
          .collection('issues')
          .doc(issueId)
          .update({
        'status': 'read',
        'readAt': FieldValue.serverTimestamp(),
        'isRead': 'true',
      });
    }
  }

  Future<void> _saveIssueUpdate(String issueId) async {
    final comment = _commentControllers[issueId]?.text.trim() ?? '';
    final isFixed = _fixedValues[issueId] ?? false;

    await FirebaseFirestore.instance.collection('issues').doc(issueId).update({
      'adminComment': comment,
      'isFixed': isFixed,
      'status': isFixed ? 'fixed' : 'read',
      'isRead': 'true',
      'updatedAt': FieldValue.serverTimestamp(),
      if (isFixed) 'fixedAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Issue update saved'),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [topBarStart, topBarEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Direct Reporting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Review user issue reports',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String text) {
    final bool selected = _selectedFilter == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? primary.withOpacity(0.25) : chipBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? primary : borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.18 : 0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? primary : subTextColor,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIssueCard(
    String issueId,
    Map<String, dynamic> issue,
  ) {
    final status = _getStatus(issue);
    final isExpanded = _expandedIssueId == issueId;

    _commentControllers.putIfAbsent(
      issueId,
      () => TextEditingController(
        text: issue['adminComment'] ?? '',
      ),
    );

    _fixedValues.putIfAbsent(issueId, () => status == 'fixed');

    return GestureDetector(
      onTap: () => _openIssue(issueId, issue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isExpanded ? primary : borderColor,
            width: isExpanded ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.22 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: iconBoxBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.report_problem_outlined,
                    size: 24,
                    color: isDark ? Colors.white : textDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue['type']?.toString() ?? '',
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        issue['details']?.toString() ??
                            issue['description']?.toString() ??
                            '',
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 13.5,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 15,
                            color: subTextColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              issue['userName']?.toString() ?? '',
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: subTextColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(issue['createdAt']),
                            style: TextStyle(
                              color: subTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(status),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _commentControllers[issueId],
                maxLines: 4,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: 'Add admin comment...',
                  hintStyle: TextStyle(color: hintColor),
                  filled: true,
                  fillColor: inputBg,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: primary),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _fixedValues[issueId] ?? false,
                    activeColor: secondary,
                    checkColor: Colors.white,
                    side: BorderSide(color: subTextColor),
                    onChanged: (value) {
                      setState(() {
                        _fixedValues[issueId] = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'Fixed',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _saveIssueUpdate(issueId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isFixed = status == 'fixed';
    final isUnread = status == 'unread';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: isFixed
            ? primary.withOpacity(0.25)
            : isUnread
                ? (isDark ? Colors.white10 : lightGreen)
                : primary.withOpacity(0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.transparent,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isFixed ? primary : titleColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterChip('All'),
                          _buildFilterChip('Unread'),
                          _buildFilterChip('Read'),
                          _buildFilterChip('Fixed'),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _getIssuesStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: secondary,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Failed to load issue reports',
                                  style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }

                            final issues =
                                _filterIssues(snapshot.data?.docs ?? []);

                            if (issues.isEmpty) {
                              return Center(
                                child: Text(
                                  'No issue reports found',
                                  style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: issues.length,
                              itemBuilder: (context, index) {
                                final doc = issues[index];

                                return _buildIssueCard(
                                  doc.id,
                                  doc.data(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AdminBar(selectedIndex: 3),
      ),
    );
  }
}
