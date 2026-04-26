import 'package:flutter/material.dart';

import 'LocationPage.dart';
import '../widgets/releaf_ui.dart';

class ReportIssueUser extends StatefulWidget {
  const ReportIssueUser({super.key});

  @override
  State<ReportIssueUser> createState() => _ReportIssueUserState();
}

class _ReportIssueUserState extends State<ReportIssueUser> {
  final List<String> issues = [
    'Incorrect classification result',
    'Wrong chatbot response',
    'App crash or feature not working',
    'Incorrect or missing recycling location',
    'Login or account issue',
    'Other',
  ];

  int _selectedIndex = 0;

  void _showIssueDialog(String issueTitle) {
    final TextEditingController detailsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ReLeafColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            issueTitle,
            style: ReLeafTextStyles.title,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  issueTitle == 'Other'
                      ? 'Please describe the issue below.'
                      : 'You can add extra details below if needed.',
                  style: ReLeafTextStyles.body,
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: detailsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write here (optional)',
                    hintStyle: const TextStyle(color: Color(0xFF8A9A8C)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ReLeafColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: ReLeafColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: ReLeafColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ReLeafButton(
              text: 'Submit',
              small: true,
              onPressed: () {
                final String details = detailsController.text.trim();

                debugPrint('Issue selected: $issueTitle');
                debugPrint('User details: $details');

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      issueTitle == 'Other'
                          ? 'Your report has been submitted.'
                          : 'Report submitted for: $issueTitle',
                    ),
                    backgroundColor: ReLeafColors.secondary,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildIssueCard(String title) {
    return ReLeafCard(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ReLeafColors.lightGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              color: ReLeafColors.textDark,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: ReLeafTextStyles.title.copyWith(fontSize: 15.5),
            ),
          ),
          const SizedBox(width: 10),
          ReLeafButton(
            text: 'Report',
            small: true,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => _showIssueDialog(title),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LocationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ReLeafHeader(
              title: 'Report an Issue',
              subtitle: 'Tell us what went wrong',
              icon: Icons.report_problem_outlined,
              showBackButton: true,
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReLeafInfoBox(
                      text:
                          'Choose the issue type, then add details if needed.',
                      icon: Icons.info_outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Issue Categories',
                      style: ReLeafTextStyles.title.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 12),
                    ...issues.map(_buildIssueCard),
                  ],
                ),
              ),
            ),
            ReLeafBottomBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
