import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:releaf_app/l10n/app_localizations.dart';

import 'package:releaf_app/widgets/app_background.dart';
import '../../widgets/releaf_ui.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

class IssueDetailsPage extends StatelessWidget {
  final String docId;
  final Map<String, dynamic> issueData;

  const IssueDetailsPage({
    super.key,
    required this.docId,
    required this.issueData,
  });

  String _formatIssueNumber(dynamic number) {
    if (number == null) return '00001';
    final intValue = int.tryParse(number.toString()) ?? 1;
    return intValue.toString().padLeft(5, '0');
  }

  int _getStep(Map<String, dynamic> data) {
    final status = data['status']?.toString().toLowerCase() ?? 'pending';
    final adminReply = data['adminComment']?.toString() ?? '';

    if (adminReply.isNotEmpty || status == 'fixed') return 2;

    if (status == 'processing' || status == 'in progress' || status == 'read') {
      return 1;
    }

    return 0;
  }

  String _translateIssueTitle(String title, AppLocalizations l) {
    switch (title.trim()) {
      case 'Incorrect classification result':
        return l.issue1;
      case 'Wrong chatbot response':
        return l.issue2;
      case 'App crash or feature not working':
        return l.issue3;
      case 'Incorrect or missing recycling location':
        return l.issue4;
      case 'Login or account issue':
        return l.issue5;
      case 'Other':
        return l.issue6;
      default:
        return title;
    }
  }

  String _translateDetails(String details, AppLocalizations l) {
    if (details.trim() == 'No additional details provided.') return l.noDetails;
    return details;
  }

  String _translateStatus(String status, AppLocalizations l) {
    switch (status.toLowerCase()) {
      case 'unread':
        return l.adminUnread;
      case 'read':
        return l.adminRead;
      case 'fixed':
        return l.adminFixed;
      case 'pending':
        return status;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color cardColor =
        isDarkMode ? const Color(0xFF1F2F2A) : Colors.white.withOpacity(0.96);

    final Color mainTextColor =
        isDarkMode ? Colors.white : ReLeafColors.textDark;

    final Color subTextColor =
        isDarkMode ? Colors.white70 : ReLeafColors.textDark.withOpacity(0.75);

    final Color borderColor = isDarkMode
        ? Colors.white.withOpacity(0.08)
        : Colors.white.withOpacity(0.8);

    final Color shadowColor = isDarkMode
        ? Colors.black.withOpacity(0.25)
        : Colors.black.withOpacity(0.06);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('issues')
                .doc(docId)
                .snapshots(),
            builder: (context, snapshot) {
              final data = snapshot.hasData && snapshot.data!.exists
                  ? snapshot.data!.data() as Map<String, dynamic>
                  : issueData;

              final rawTitle = data['title']?.toString() ?? '';
              final rawDetails = data['details']?.toString() ?? '';
              final rawStatus = data['status']?.toString() ?? 'pending';

              final title = rawTitle.isEmpty
                  ? l.complaint
                  : _translateIssueTitle(rawTitle, l);

              final details = _translateDetails(rawDetails, l);

              final status = _translateStatus(rawStatus, l);

              final adminReply = data['adminComment']?.toString() ?? '';

              final currentStep = _getStep(data);

              return Column(
                children: [
                  AppTopBar(
                    title: l.complaintDetails,
                    icon: Icons.assignment_outlined,
                    showBackButton: true,
                    showNotifications: false,
                    gradientColors: isDarkMode
                        ? const [Color(0xFF1B3A31), Color(0xFF2F5D50)]
                        : const [Color(0xFF7FB77E), Color(0xFF5E9C76)],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoCard(
                            context: context,
                            title: title,
                            details: details,
                            status: status,
                            cardColor: cardColor,
                            mainTextColor: mainTextColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
                            shadowColor: shadowColor,
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(height: 22),
                          Text(
                            l.requestTimeline,
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 22,
                              color: mainTextColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTimeline(
                            context: context,
                            currentStep: currentStep,
                            cardColor: cardColor,
                            mainTextColor: mainTextColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
                            shadowColor: shadowColor,
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            l.adminReply,
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 22,
                              color: mainTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildReplyBox(
                            context: context,
                            adminReply: adminReply,
                            cardColor: cardColor,
                            mainTextColor: mainTextColor,
                            subTextColor: subTextColor,
                            borderColor: borderColor,
                            shadowColor: shadowColor,
                            isDarkMode: isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required String details,
    required String status,
    required Color cardColor,
    required Color mainTextColor,
    required Color subTextColor,
    required Color borderColor,
    required Color shadowColor,
    required bool isDarkMode,
  }) {
    return _customCard(
      cardColor: cardColor,
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ReLeafTextStyles.title.copyWith(
              fontSize: 20,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            details,
            style: ReLeafTextStyles.body.copyWith(
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFF2E4A3D)
                  : ReLeafColors.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: ReLeafTextStyles.body.copyWith(
                color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline({
    required BuildContext context,
    required int currentStep,
    required Color cardColor,
    required Color mainTextColor,
    required Color subTextColor,
    required Color borderColor,
    required Color shadowColor,
    required bool isDarkMode,
  }) {
    final l = AppLocalizations.of(context)!;

    final steps = [
      {
        'title': l.step1Title,
        'subtitle': l.step1Sub,
        'icon': Icons.send_rounded,
      },
      {
        'title': l.step2Title,
        'subtitle': l.step2Sub,
        'icon': Icons.manage_search_rounded,
      },
      {
        'title': l.step3Title,
        'subtitle': l.step3Sub,
        'icon': Icons.check_circle_rounded,
      },
    ];

    return _customCard(
      cardColor: cardColor,
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: Column(
        children: List.generate(steps.length, (index) {
          final isActive = index <= currentStep;
          final isLast = index == steps.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isActive
                          ? ReLeafColors.primary
                          : isDarkMode
                              ? const Color(0xFF31443B)
                              : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      steps[index]['icon'] as IconData,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 3,
                      height: 48,
                      color: index < currentStep
                          ? ReLeafColors.primary
                          : isDarkMode
                              ? const Color(0xFF31443B)
                              : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index]['title'] as String,
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 17,
                          color: isActive ? mainTextColor : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        steps[index]['subtitle'] as String,
                        style: ReLeafTextStyles.body.copyWith(
                          fontSize: 13,
                          color: isActive ? subTextColor : Colors.grey,
                        ),
                      ),
                      if (!isLast) const SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildReplyBox({
    required BuildContext context,
    required String adminReply,
    required Color cardColor,
    required Color mainTextColor,
    required Color subTextColor,
    required Color borderColor,
    required Color shadowColor,
    required bool isDarkMode,
  }) {
    final l = AppLocalizations.of(context)!;

    final hasReply = adminReply.trim().isNotEmpty;

    return _customCard(
      cardColor: cardColor,
      borderColor:
          hasReply ? ReLeafColors.primary.withOpacity(0.35) : borderColor,
      shadowColor: shadowColor,
      child: hasReply
          ? Text(
              adminReply,
              style: ReLeafTextStyles.body.copyWith(
                color: mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            )
          : Row(
              children: [
                const Icon(
                  Icons.hourglass_empty_rounded,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.waitingReply,
                    style: ReLeafTextStyles.body.copyWith(
                      color: isDarkMode ? Colors.white60 : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _customCard({
    required Widget child,
    required Color cardColor,
    required Color borderColor,
    required Color shadowColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
