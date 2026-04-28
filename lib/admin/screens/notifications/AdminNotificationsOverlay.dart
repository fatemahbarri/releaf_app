import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/admin_theme.dart';

class AdminNotificationsOverlay extends StatelessWidget {
  final int newNotifications;

  const AdminNotificationsOverlay({
    super.key,
    required this.newNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AdminTheme.backgroundDark,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.notifications,
                          color: AdminTheme.textDark,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AdminTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AdminTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    newNotifications == 0
                        ? 'No new issues'
                        : 'You have $newNotifications new issue(s)',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AdminTheme.textMedium,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('issues')
                      .where('status', isEqualTo: 'unread')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: CircularProgressIndicator(
                          color: AdminTheme.primary,
                        ),
                      );
                    }

                    final issues = snapshot.data?.docs ?? [];

                    if (issues.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: issues.length,
                      itemBuilder: (context, index) {
                        final issue = issues[index].data();
                        final title =
                            (issue['type'] ?? 'New issue reported').toString();

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AdminTheme.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.report_problem,
                                  color: AdminTheme.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: AdminTheme.textDark,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}