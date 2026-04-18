import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const Profile({
    super.key,
    required this.name,
    required this.email,
    this.password = '**************',
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Later, connect these to your real screens
    switch (index) {
      case 0:
        debugPrint('Go to Home');
        break;
      case 1:
        debugPrint('Go to Camera');
        break;
      case 2:
        debugPrint('Go to Bins');
        break;
      case 3:
        debugPrint('Already in Profile');
        break;
    }
  }

  void _handleLogout() {
    debugPrint('Log Out pressed');
    // Later:
    // Navigator.pushReplacement(...);
  }

  void _handleEditProfile() {
    debugPrint('Edit profile pressed');
    // Later:
    // Open edit profile screen or dialog
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF4E6757),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4E6757),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFCDE9C7),
                            border: Border.all(
                              color: const Color(0xFF4E6757),
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF4E6757),
                          ),
                        ),
                        Positioned(
                          right: -2,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: _handleEditProfile,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4E6757),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFF3FFE2),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Color(0xFF7CA385),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 32),

                    _buildInfoCard(
                      title: 'Email',
                      value: widget.email,
                    ),

                    const SizedBox(height: 20),

                    _buildInfoCard(
                      title: 'Password',
                      value: widget.password,
                    ),

                    const SizedBox(height: 60),

                    ElevatedButton(
                      onPressed: _handleLogout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB8D97A),
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xFF9C1111),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFCDE9C7),
              selectedItemColor: const Color(0xFF4E6757),
              unselectedItemColor: Colors.black54,
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

  Widget _buildInfoCard({
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFCDE9C7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB0B0B0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF498056),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF675F5A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}