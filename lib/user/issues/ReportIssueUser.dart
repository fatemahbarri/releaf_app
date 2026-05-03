import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'IssueDetailsPage.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';
import '../../widgets/releaf_ui.dart';

import 'package:releaf_app/widgets/app_top_bar.dart';

class ReportIssueUser extends StatefulWidget {
  const ReportIssueUser({super.key});

  @override
  State<ReportIssueUser> createState() => _ReportIssueUserState();
}

class _ReportIssueUserState extends State<ReportIssueUser> {
  int selectedTab = 0;

  final List<String> issues = [
    'Incorrect classification result',
    'Wrong chatbot response',
    'App crash or feature not working',
    'Incorrect or missing recycling location',
    'Login or account issue',
    'Other',
  ];

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color get cardColor => isDarkMode ? const Color(0xFF1F2F2A) : Colors.white;

  Color get iconBoxColor =>
      isDarkMode ? const Color(0xFF2E4A3D) : ReLeafColors.lightGreen;

  Color get mainTextColor => isDarkMode ? Colors.white : ReLeafColors.textDark;

  Color get subTextColor =>
      isDarkMode ? Colors.white70 : ReLeafColors.textDark.withOpacity(0.65);

  Color get borderColor => isDarkMode
      ? Colors.white.withOpacity(0.08)
      : Colors.white.withOpacity(0.8);

  Color get shadowColor => isDarkMode
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.06);

  Future<void> _submitIssue(String issueTitle, String details) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final firestore = FirebaseFirestore.instance;

    final snapshot = await firestore
        .collection('issues')
        .where('userId', isEqualTo: user.uid)
        .get();

    final nextNumber = snapshot.docs.length + 1;
    final issueNumber = nextNumber.toString().padLeft(5, '0');

    await firestore.collection('issues').add({
      'issueNumber': issueNumber,
      'title': issueTitle,
      'type': issueTitle,
      'details': details.isEmpty ? 'No additional details provided.' : details,
      'userName': user.email ?? 'User',
      'userEmail': user.email ?? '',
      'userId': user.uid,
      'status': 'Pending',
      'adminReply': '',
      'isReadByUser': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  void _showIssueDialog(String issueTitle) {
    final TextEditingController detailsController = TextEditingController();
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: Text(
                issueTitle,
                style: ReLeafTextStyles.title.copyWith(
                  color: mainTextColor,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      issueTitle == 'Other'
                          ? 'Please describe the issue below.'
                          : 'You can add extra details below if needed.',
                      style: ReLeafTextStyles.body.copyWith(
                        color: subTextColor,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: detailsController,
                      maxLines: 5,
                      style: TextStyle(color: mainTextColor),
                      decoration: InputDecoration(
                        hintText: 'Write here (optional)',
                        hintStyle: TextStyle(color: subTextColor),
                        filled: true,
                        fillColor:
                            isDarkMode ? const Color(0xFF14221D) : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: ReLeafColors.secondary,
                            width: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSubmitting ? null : () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: subTextColor),
                  ),
                ),
                ReLeafButton(
                  text: isSubmitting ? 'Saving...' : 'Submit',
                  small: true,
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          final details = detailsController.text.trim();

                          setDialogState(() {
                            isSubmitting = true;
                          });

                          try {
                            await _submitIssue(issueTitle, details);

                            if (!mounted) return;

                            Navigator.pop(context);

                            setState(() {
                              selectedTab = 1;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Your complaint has been received successfully.',
                                ),
                                backgroundColor: ReLeafColors.secondary,
                              ),
                            );
                          } catch (e) {
                            if (!mounted) return;

                            setDialogState(() {
                              isSubmitting = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Failed to submit report. Please try again.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.96),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTabButton('New Report', 0),
          _buildTabButton('Previous Reports', 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? iconBoxColor : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: ReLeafTextStyles.title.copyWith(
              fontSize: 15,
              color: isSelected ? ReLeafColors.primary : subTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewReportPage() {
    return Column(
      children: [
        _infoBox(
          'Choose the issue type, then add details if needed.',
        ),
        const SizedBox(height: 16),
        ...issues.map(_buildIssueCard),
      ],
    );
  }

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.96),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: ReLeafTextStyles.body.copyWith(
          color: subTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildIssueCard(String title) {
    return _customCard(
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBoxColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.report_problem_outlined,
              color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: ReLeafTextStyles.body.copyWith(
                color: mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ReLeafButton(
            text: 'Report',
            small: true,
            onPressed: () => _showIssueDialog(title),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousReportsPage() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(
        child: Text(
          'Please login first.',
          style: ReLeafTextStyles.body.copyWith(color: mainTextColor),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('issues')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Error loading reports.',
            style: ReLeafTextStyles.body.copyWith(color: Colors.red),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 90,
                  color: isDarkMode
                      ? Colors.white38
                      : ReLeafColors.primary.withOpacity(0.45),
                ),
                const SizedBox(height: 16),
                Text(
                  'No previous reports yet.',
                  style: ReLeafTextStyles.title.copyWith(
                    fontSize: 20,
                    color: mainTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your submitted reports will appear here.',
                  textAlign: TextAlign.center,
                  style: ReLeafTextStyles.body.copyWith(
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          );
        }

        final reports = snapshot.data!.docs;

        reports.sort((a, b) {
          final aData = a.data() as Map<String, dynamic>;
          final bData = b.data() as Map<String, dynamic>;

          final aTime = aData['createdAt'];
          final bTime = bData['createdAt'];

          if (aTime is Timestamp && bTime is Timestamp) {
            return bTime.compareTo(aTime);
          }

          return 0;
        });

        return Column(
          children: reports.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            final issueNumber = data['issueNumber']?.toString() ?? '00001';
            final title = data['title']?.toString() ?? 'Complaint';
            final details = data['details']?.toString() ?? '';
            final status = data['status']?.toString() ?? 'Pending';
            final adminReply = data['adminReply']?.toString() ?? '';

            final isCompleted = status.toLowerCase() == 'completed' ||
                status.toLowerCase() == 'answered' ||
                adminReply.isNotEmpty;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IssueDetailsPage(
                      docId: doc.id,
                      issueData: data,
                    ),
                  ),
                );
              },
              child: _customCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: iconBoxColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            isCompleted
                                ? Icons.check_circle_outline
                                : Icons.hourglass_top_rounded,
                            color: isCompleted ? Colors.green : Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Complaint #$issueNumber',
                            style: ReLeafTextStyles.title.copyWith(
                              fontSize: 17,
                              color: mainTextColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.green.withOpacity(0.12)
                                : Colors.orange.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isCompleted ? 'Answered' : status,
                            style: TextStyle(
                              color: isCompleted ? Colors.green : Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: ReLeafTextStyles.body.copyWith(
                        color: mainTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      details,
                      style: ReLeafTextStyles.body.copyWith(
                        color: subTextColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'For more details, tap',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white38
                            : Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (adminReply.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF14221D)
                              : ReLeafColors.lightGreen.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          'Admin reply: $adminReply',
                          style: ReLeafTextStyles.body.copyWith(
                            color: mainTextColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _customCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.96),
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

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: 'Report an Issue',
                icon: Icons.report_problem_outlined,
                showBackButton: true,
                showNotifications: false,
                gradientColors: Theme.of(context).brightness == Brightness.dark
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
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 100),
                  child: Column(
                    children: [
                      _buildTabs(),
                      const SizedBox(height: 18),
                      selectedTab == 0
                          ? _buildNewReportPage()
                          : _buildPreviousReportsPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 3,
        ),
      ),
    );
  }
}
