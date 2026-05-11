import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:releaf_app/l10n/app_localizations.dart';
import '../../../theme/admin_theme.dart';
import 'package:releaf_app/admin/screens/reports/AdminReportIssue.dart';

class AdminNotificationsOverlay extends StatelessWidget {
  final int newNotifications;

  const AdminNotificationsOverlay({
    super.key,
    required this.newNotifications,
  });

  String _translateIssueType(AppLocalizations l10n, String type) {
    final value = type.trim().toLowerCase();

    switch (value) {
      case 'incorrect classification result':
        return l10n.incorrectClassificationResult;
      case 'app crash or feature not working':
        return l10n.appCrashOrFeatureNotWorking;
      case 'wrong chatbot response':
        return l10n.wrongChatbotResponse;
      default:
        return type.isEmpty ? l10n.adminNotificationDefaultReport : type;
    }
  }

  String _translateStatus(AppLocalizations l10n, String status) {
    final value = status.trim().toLowerCase();

    switch (value) {
      case 'pending':
        return l10n.adminNotificationPendingStatus;
      case 'read':
        return l10n.read;
      case 'unread':
        return l10n.unread;
      case 'resolved':
      case 'fixed':
        return l10n.resolved;
      default:
        return status.isEmpty ? l10n.adminNotificationPendingStatus : status;
    }
  }

  String _translateDescription(AppLocalizations l10n, String description) {
    final value = description.trim().toLowerCase();

    if (value.isEmpty ||
        value.contains('no additional details') ||
        value.contains('no details')) {
      return l10n.adminNotificationNoDetails;
    }

    return description;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color cardBg = isDark ? const Color(0xFF1F2D28) : Colors.white;
    final Color containerBg =
        isDark ? const Color(0xFF17211C) : AdminTheme.backgroundDark;
    final Color titleColor = isDark ? Colors.white : AdminTheme.textDark;
    final Color subText = isDark ? Colors.white70 : AdminTheme.textMedium;

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
              color: containerBg,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.35 : 0.25),
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
                      children: [
                        Icon(Icons.notifications_rounded, color: titleColor),
                        const SizedBox(width: 8),
                        Text(
                          l10n.adminNotificationOverlayTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white10
                              : Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: titleColor,
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
                        ? l10n.adminNotificationNoReports
                        : l10n.adminNotificationNewReportsCount(
                            newNotifications,
                          ),
                    style: TextStyle(
                      fontSize: 14,
                      color: subText,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('issues')
                      .where('isRead', isEqualTo: false)
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          l10n.adminNotificationEmpty,
                          style: TextStyle(
                            color: subText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 420),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: issues.length,
                        itemBuilder: (context, index) {
                          final doc = issues[index];
                          final issue = doc.data();

                          final String issueId = doc.id;

                          final String type = _translateIssueType(
                            l10n,
                            (issue['type'] ?? '').toString(),
                          );

                          final String status = _translateStatus(
                            l10n,
                            (issue['status'] ?? '').toString(),
                          );

                          final String description = _translateDescription(
                            l10n,
                            (issue['details'] ?? '').toString(),
                          );

                          final String userName =
                              (issue['userName'] ?? 'User').toString();

                          return GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection('issues')
                                  .doc(issueId)
                                  .update({'isRead': true});

                              Navigator.pop(context);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AdminReportIssue(
                                    selectedIssueId: issueId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white10
                                      : AdminTheme.primary.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      isDark ? 0.25 : 0.08,
                                    ),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color:
                                          AdminTheme.primary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.report_problem_rounded,
                                      color: AdminTheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          type,
                                          style: TextStyle(
                                            color: titleColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          l10n.adminNotificationFromUser(
                                            userName,
                                          ),
                                          style: TextStyle(
                                            color: subText,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: subText,
                                            fontSize: 13,
                                            height: 1.35,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AdminTheme.primary
                                                .withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            status,
                                            style: const TextStyle(
                                              color: AdminTheme.primary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: subText,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
