import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/AdminBar.dart';

class AdminReportIssue extends StatefulWidget {
  const AdminReportIssue({super.key});

  @override
  State<AdminReportIssue> createState() => _AdminReportIssueState();
}

class _AdminReportIssueState extends State<AdminReportIssue> {
  String _selectedFilter = 'All';

  static const Color primary = Color(0xFF7FB77E);
  static const Color secondary = Color(0xFF5E9C76);
  static const Color background = Color(0xFFF7FBF2);
  static const Color lightGreen = Color(0xFFEAF6E3);
  static const Color border = Color(0xFFDCE8D7);
  static const Color textDark = Color(0xFF2F5D50);
  static const Color textMedium = Color(0xFF4E6A57);
  static const Color error = Color(0xFFE85A5A);

  Stream<QuerySnapshot<Map<String, dynamic>>> _getIssuesStream() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('issues')
        .orderBy('createdAt', descending: true);

    if (_selectedFilter != 'All') {
      query = FirebaseFirestore.instance
          .collection('issues')
          .where('status', isEqualTo: _selectedFilter.toLowerCase())
          .orderBy('createdAt', descending: true);
    }

    return query.snapshots();
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return '';

    final date = (timestamp as Timestamp).toDate();

    return '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
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
          color: selected ? primary.withOpacity(0.25) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? primary : border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? textDark : textMedium,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue) {
    final status = (issue['status'] ?? '').toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              size: 24,
              color: textDark,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue['type'] ?? '',
                  style: const TextStyle(
                    color: textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  issue['details'] ?? '',
                  style: const TextStyle(
                    color: textMedium,
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 15,
                      color: textMedium,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        issue['userName'] ?? '',
                        style: const TextStyle(
                          color: textMedium,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: textMedium,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(issue['createdAt']),
                      style: const TextStyle(
                        color: textMedium,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (status.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: status == 'closed'
                    ? error.withOpacity(0.15)
                    : primary.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'closed' ? error : textDark,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                        _buildFilterChip('Closed'),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                            return const Center(
                              child: Text(
                                'Failed to load issue reports',
                                style: TextStyle(
                                  color: textMedium,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          final issues = snapshot.data?.docs ?? [];

                          if (issues.isEmpty) {
                            return const Center(
                              child: Text(
                                'No issue reports found',
                                style: TextStyle(
                                  color: textMedium,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: issues.length,
                            itemBuilder: (context, index) {
                              final issue = issues[index].data();
                              return _buildIssueCard(issue);
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
    );
  }
}