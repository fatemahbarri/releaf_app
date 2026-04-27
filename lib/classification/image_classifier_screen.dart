import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/releaf_ui.dart';
import '../user/HomePageUser.dart';
import '../user/LocationPage.dart';
import '../user/Profile.dart';
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

  void _onBottomTap(int index) {
    if (index == 1) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePageUser(),
        ),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationPage(),
        ),
      );
    }

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Profile(
            name: 'User',
            email: 'user@email.com',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReLeafColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const ReLeafHeader(
              title: 'Waste Classification',
              subtitle: 'Take or upload a waste image',
              icon: Icons.camera_alt_outlined,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReLeafCard(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: double.infinity,
                          height: 340,
                          color: Colors.white,
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.contain,
                                )
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.image_outlined,
                                          color: ReLeafColors.textMedium,
                                          size: 54,
                                        ),
                                        const SizedBox(height: 14),
                                        Text(
                                          'Take a photo or upload a waste image',
                                          textAlign: TextAlign.center,
                                          style: ReLeafTextStyles.body.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: ReLeafButton(
                              text: 'Take Photo',
                              icon: Icons.camera_alt_outlined,
                              onPressed: _pickCamera,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Center(
                            child: ReLeafButton(
                              text: 'Upload',
                              icon: Icons.upload_rounded,
                              onPressed: _pickGallery,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: ReLeafButton(
                        text: 'Learn More',
                        icon: Icons.info_outline,
                        onPressed: _learnMore,
                      ),
                    ),

                    const SizedBox(height: 26),

                    Text(
                      'Result',
                      style: ReLeafTextStyles.title.copyWith(fontSize: 22),
                    ),

                    const SizedBox(height: 12),

                    ReLeafCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      color: ReLeafColors.lightGreen,
                      child: Column(
                        children: [
                          _isLoading
                              ? const CircularProgressIndicator(
                                  color: ReLeafColors.secondary,
                                )
                              : Text(
                                  _result,
                                  textAlign: TextAlign.center,
                                  style: ReLeafTextStyles.title.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                          if (_confidence.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Confidence: $_confidence',
                              style: ReLeafTextStyles.subtitle,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ReLeafBottomBar(
              selectedIndex: 1,
              onTap: _onBottomTap,
            ),
          ],
        ),
      ),
    );
  }
}