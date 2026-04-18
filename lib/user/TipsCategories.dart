import 'package:flutter/material.dart';
import 'LocationPage.dart';

class TipsCategories extends StatefulWidget {
  const TipsCategories({super.key});

  @override
  State<TipsCategories> createState() => _TipsCategoriesState();
}

class _TipsCategoriesState extends State<TipsCategories> {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            issueTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF499A64),
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
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: detailsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write here (optional)',
                    filled: true,
                    fillColor: const Color(0xFFF7F7F7),
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF499A64),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final String details = detailsController.text.trim();

                // Later, you can send this data to Firebase / Firestore
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
                    backgroundColor: const Color(0xFF499A64),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9CD74F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIssueCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18, left: 24, right: 24),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFB5B5B5)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _showIssueDialog(title),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA9DC5A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              'Learn More',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });

  if (index == 2) { // 👈 Bins button
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
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 28, bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF666666),
                              size: 26,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 40),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF499A64),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Report an Issue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    ...issues.map(_buildIssueCard),
                  ],
                ),
              ),
            ),

            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFCDE9C7),
              selectedItemColor: const Color(0xFF4F6F52),
              unselectedItemColor: const Color(0xFF49454F),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_outlined),
                  activeIcon: Icon(Icons.camera_alt),
                  label: 'Camera',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),
                  activeIcon: Icon(Icons.location_on),
                  label: 'Bins',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}