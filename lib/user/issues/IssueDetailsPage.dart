import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final adminReply = data['adminReply']?.toString() ?? '';

    if (adminReply.isNotEmpty ||
        status == 'completed' ||
        status == 'answered') {
      return 2;
    }

    if (status == 'processing' || status == 'in progress' || status == 'read') {
      return 1;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
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

              final issueNumber = _formatIssueNumber(data['issueNumber']);
              final title = data['title']?.toString() ?? 'Complaint';
              final details = data['details']?.toString() ?? '';
              final status = data['status']?.toString() ?? 'Pending';
              final adminReply = data['adminReply']?.toString() ?? '';
              final currentStep = _getStep(data);

              return Column(
                children: [
                  AppTopBar(
                    title: 'Complaint Details',
                    icon: Icons.assignment_outlined,
                    showBackButton: true,
                    showNotifications: false,
                    gradientColors:
                        Theme.of(context).brightness == Brightness.dark
                            ? [
                                const Color(0xFF1B3A31),
                                const Color(0xFF2F5D50),
                              ]
                            : [
                                const Color(0xFF7FB77E),
                                const Color(0xFF5E9C76),
                              ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoCard(
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
                            'Request Timeline',
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 22,
                              color: mainTextColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTimeline(
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
                            'Admin Reply',
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 22,
                              color: mainTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildReplyBox(
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
            details.isEmpty ? 'No additional details provided.' : details,
            style: ReLeafTextStyles.body.copyWith(
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
    required int currentStep,
    required Color cardColor,
    required Color mainTextColor,
    required Color subTextColor,
    required Color borderColor,
    required Color shadowColor,
    required bool isDarkMode,
  }) {
    final steps = [
      {
        'title': 'Request Submitted',
        'subtitle': 'Your complaint has been sent successfully.',
        'icon': Icons.send_rounded,
      },
      {
        'title': 'Processing Request',
        'subtitle': 'The admin is reviewing your complaint.',
        'icon': Icons.manage_search_rounded,
      },
      {
        'title': 'Request Completed',
        'subtitle': 'The admin has replied to your complaint.',
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
    required String adminReply,
    required Color cardColor,
    required Color mainTextColor,
    required Color subTextColor,
    required Color borderColor,
    required Color shadowColor,
    required bool isDarkMode,
  }) {
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
                    'Waiting for admin reply...',
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
