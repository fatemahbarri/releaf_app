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
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Error loading notifications:\n${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: ReLeafTextStyles.body.copyWith(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
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

                          issues.sort((a, b) {
                            final aData = a.data() as Map<String, dynamic>;
                            final bData = b.data() as Map<String, dynamic>;

                            final aTime = aData['createdAt'];
                            final bTime = bData['createdAt'];

                            if (aTime is Timestamp && bTime is Timestamp) {
                              return bTime.compareTo(aTime);
                            }

                            return 0;
                          });

                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                            itemCount: issues.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final doc = issues[index];
                              final data = doc.data() as Map<String, dynamic>;

                              final issueNumber =
                                  _formatIssueNumber(data['issueNumber']);
                              final status =
                                  data['status']?.toString() ?? 'Pending';
                              final title =
                                  data['title']?.toString() ?? 'Complaint';
                              final reply =
                                  data['adminReply']?.toString() ?? '';
                              final isRead = data['isReadByUser'] == true;

                              final isCompleted =
                                  status.toLowerCase() == 'completed' ||
                                      status.toLowerCase() == 'answered' ||
                                      reply.isNotEmpty;

                              final message = isCompleted
                                  ? 'Your complaint #$issueNumber has been answered.'
                                  : 'Your complaint has been received successfully. Complaint number: #$issueNumber. We will respond to you soon.';

                              return GestureDetector(
                                onTap: () => _markAsRead(doc.id),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: cardColor,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: isRead
                                          ? borderColor.withOpacity(
                                              isDark ? 0.6 : 0.4,
                                            )
                                          : ReLeafColors.primary.withOpacity(
                                              isDark ? 0.8 : 0.45,
                                            ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                          isDark ? 0.30 : 0.06,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ReLeafColors.primary
                                              .withOpacity(
                                                  isDark ? 0.22 : 0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isCompleted
                                              ? Icons.mark_email_read_outlined
                                              : Icons
                                                  .notifications_active_outlined,
                                          color: isDark
                                              ? Colors.white
                                              : ReLeafColors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Complaint #$issueNumber',
                                              style: ReLeafTextStyles.title
                                                  .copyWith(
                                                fontSize: 17,
                                                color: textColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              title,
                                              style: ReLeafTextStyles.body
                                                  .copyWith(
                                                fontSize: 13,
                                                color: subTextColor,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              message,
                                              style: ReLeafTextStyles.body
                                                  .copyWith(
                                                fontSize: 13,
                                                color: isCompleted
                                                    ? const Color(0xFF66BB6A)
                                                    : const Color(0xFFFFB74D),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (reply.isNotEmpty) ...[
                                              const SizedBox(height: 8),
                                              Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? const Color(0xFF101814)
                                                      : const Color(0xFFF4F8EF),
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: borderColor,
                                                  ),
                                                ),
                                                child: Text(
                                                  'Admin reply: $reply',
                                                  style: ReLeafTextStyles.body
                                                      .copyWith(
                                                    fontSize: 13,
                                                    color: subTextColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      if (!isRead)
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
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
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 0,
        ),
      ),
    );
  }
}
