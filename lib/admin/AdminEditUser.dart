import 'package:flutter/material.dart';
import 'AdminBar.dart';
import 'AdminUserManagment.dart';

class AdminEditUser extends StatefulWidget {
  final Map<String, String>? user;

  const AdminEditUser({super.key, this.user});

  @override
  State<AdminEditUser> createState() => _AdminEditUserState();
}

class _AdminEditUserState extends State<AdminEditUser> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late String status;

  @override
  void initState() {
    super.initState();

    // بيانات مؤقتة إذا ما انرسلت بيانات من الصفحة السابقة
    final currentUser =
        widget.user ??
        {
          'name': 'Sara Abdullah',
          'email': 'sara@gmail.com',
          'status': 'Active',
        };

    final fullName = currentUser['name'] ?? '';
    final nameParts = fullName.split(' ');

    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    final email = currentUser['email'] ?? '';
    status = currentUser['status'] ?? 'Active';

    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    usernameController = TextEditingController(text: firstName.toLowerCase());
    emailController = TextEditingController(text: email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${firstNameController.text} ${lastNameController.text}'
        .trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF3FFE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminUserManagment(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF4D9B63),
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 90, color: Color(0xFF7CA385)),
              ),
              const SizedBox(height: 16),
              Text(
                fullName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: status == 'Active'
                      ? const Color(0xFF7ACD0E)
                      : const Color(0xFFE47D0F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                color: const Color(0xADB0B0B0),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                height: 1,
                width: double.infinity,
              ),
              const SizedBox(height: 24),
              _buildField(firstNameController),
              _buildField(lastNameController),
              _buildField(usernameController),
              _buildField(emailController),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  // مؤقتًا فقط
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved locally for now')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DC149),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFF5B5656),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdminBar(selectedIndex: 1),
    );
  }

  Widget _buildField(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 43, right: 43),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC4C4C4), width: 1),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
