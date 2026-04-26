import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/app_background.dart';
import '../user/UserWidgets/UserBottomNav.dart';
import 'tflite_helper.dart';

class ImageClassifierScreen extends StatefulWidget {
  const ImageClassifierScreen({super.key});

  @override
  State<ImageClassifierScreen> createState() => _ImageClassifierScreenState();
}

class _ImageClassifierScreenState extends State<ImageClassifierScreen> {
  File? _image;
  String _result = 'No result yet';
  String _confidence = '';
  bool _isLoading = false;
  bool _isModelLoaded = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await TFLiteHelper.init();
    if (!mounted) return;

    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> _runClassification(File file) async {
    if (!_isModelLoaded) return;

    setState(() {
      _isLoading = true;
      _result = 'Classifying...';
      _confidence = '';
    });

    final result = await TFLiteHelper.classifyImage(file);

    if (!mounted) return;

    setState(() {
      _result = result['label'].toString();
      _confidence = '${(result['confidence'] * 100).toStringAsFixed(2)}%';
      _isLoading = false;
    });
  }

  Future<void> _pickCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      final file = File(picked.path);
      setState(() => _image = file);
      await _runClassification(file);
    }
  }

  Future<void> _pickGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      setState(() => _image = file);
      await _runClassification(file);
    }
  }

  void _learnMore() {}

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
            child: Column(
              children: [
                // Title
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF56A36C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Waste Classification",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Image box
                Container(
                  width: 320,
                  height: 370,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF56A36C),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.contain)
                        : Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: Text(
                                "Take a photo or upload a waste image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 28),

                // Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: _buildOvalButton(
                        text: "Take Photo",
                        icon: Icons.camera_alt_outlined,
                        color: const Color(0xFF499A64),
                        onTap: _pickCamera,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildOvalButton(
                        text: "Upload",
                        icon: Icons.upload_rounded,
                        color: const Color(0xFF8DC149),
                        onTap: _pickGallery,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Learn More
                _buildOvalButton(
                  text: "Learn More",
                  icon: Icons.info_outline,
                  color: const Color(0xFF8DC149),
                  onTap: _learnMore,
                ),

                const SizedBox(height: 36),

                // Result
                const Text(
                  "Result",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      _isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              _result,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                      if (_confidence.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text("Confidence: $_confidence"),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 1,
        ),
      ),
    );
  }

  // 👇 الأزرار البيضاوية
  Widget _buildOvalButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
