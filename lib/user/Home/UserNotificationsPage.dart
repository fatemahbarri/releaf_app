import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';

class UserNotificationsPage extends StatelessWidget {
  const UserNotificationsPage({super.key});

  String _formatIssueNumber(dynamic number) {
    if (number == null) return '00001';
    final intValue = int.tryParse(number.toString()) ?? 1;
    return intValue.toString().padLeft(5, '0');
  }

  Future<void> _markAsRead(String docId) async {
    await FirebaseFirestore.instance.collection('issues').doc(docId).update({
      'isReadByUser': true,
    });
  }

  bool _isResolved(String status) {
    final s = status.toLowerCase().trim();
    return s == 'resolved' || s == 'completed' || s == 'fixed' || s == 'solved';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color textColor = isDark ? Colors.white : const Color(0xFF263328);
    final Color subTextColor =
        isDark ? Colors.white70 : const Color(0xFF4E6A57);
    final Color cardColor =
        isDark ? const Color(0xFF1A2520) : Colors.white.withOpacity(0.95);
    final Color borderColor =
        isDark ? const Color(0xFF355246) : const Color(0xFFD6EBCF);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: 'Notifications',
                subtitle: 'Track your complaints updates',
                icon: Icons.notifications_none_rounded,
                showBackButton: true,
                showNotifications: false,
                gradientColors: isDark
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
                child: user == null
                    ? Center(
                        child: Text(
                          'Please login first.',
                          style: ReLeafTextStyles.body.copyWith(
                            color: subTextColor,
                          ),
                        ),
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('issues')
                            .where('userId', isEqualTo: user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'No notifications yet.',
                                style: ReLeafTextStyles.body.copyWith(
                                  color: subTextColor,
                                ),
                              ),
                            );
                          }

                          final issues = snapshot.data!.docs;

                          // 🔥 هنا السحر: نحول كل شكوى إلى إشعارين
                          final List<Map<String, dynamic>> notifications = [];

                          for (var doc in issues) {
                            final data = doc.data() as Map<String, dynamic>;
                            final status =
                                data['status']?.toString() ?? 'pending';

                            // إشعار الاستلام
                            notifications.add({
                              'docId': doc.id,
                              'data': data,
                              'type': 'received',
                            });

                            // إشعار الحل (إذا انحلت)
                            if (_isResolved(status)) {
                              notifications.add({
                                'docId': doc.id,
                                'data': data,
                                'type': 'resolved',
                              });
                            }
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = notifications[index];
                              final data = item['data'] as Map<String, dynamic>;

                              final issueNumber =
                                  _formatIssueNumber(data['issueNumber']);
                              final title =
                                  data['title']?.toString() ?? 'Complaint';
                              final reply =
                                  data['adminReply']?.toString() ?? '';
                              final type = item['type'];

                              final isResolved = type == 'resolved';

                              final message = isResolved
                                  ? 'Your complaint #$issueNumber has been resolved successfully.'
                                  : 'Your complaint #$issueNumber has been received successfully.';

                              final color = isResolved
                                  ? const Color(0xFF66BB6A)
                                  : const Color(0xFFFFB74D);

                              final icon = isResolved
                                  ? Icons.check_circle_outline
                                  : Icons.notifications_active_outlined;

                              return GestureDetector(
                                onTap: () => _markAsRead(item['docId']),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.15),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(icon, color: color),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              isResolved
                                                  ? 'Resolved #$issueNumber'
                                                  : 'Received #$issueNumber',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              title,
                                              style: TextStyle(
                                                  color: subTextColor),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              message,
                                              style: TextStyle(
                                                color: color,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (isResolved && reply.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  'Admin: $reply',
                                                  style: TextStyle(
                                                      color: subTextColor),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UserBottomNav(currentIndex: 0),
      ),
    );
  }
}
