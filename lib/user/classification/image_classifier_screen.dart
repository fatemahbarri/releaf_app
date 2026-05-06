import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:releaf_app/widgets/releaf_ui.dart';
import 'package:releaf_app/widgets/app_background.dart';
import 'package:releaf_app/widgets/app_top_bar.dart';

import 'package:releaf_app/user/Home/HomePageUser.dart';
import 'package:releaf_app/user/Bins/LocationPage.dart';
import 'package:releaf_app/user/profile/Profile.dart';
import 'package:releaf_app/user/UserWidgets/UserBottomNav.dart';

import 'package:releaf_app/user/classification/LearnMore.dart';
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
  double _confidenceValue = 0.0;

  bool _isLoading = false;
  bool _isModelLoaded = false;

  final ImagePicker _picker = ImagePicker();

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  Color get cardColor =>
      isDarkMode ? const Color(0xFF1F2F2A) : Colors.white.withOpacity(0.96);

  Color get innerCardColor =>
      isDarkMode ? const Color(0xFF14221D) : Colors.white;

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

  List<Color> get topBarGradient => isDarkMode
      ? const [
          Color(0xFF1B3A31),
          Color(0xFF2F5D50),
        ]
      : const [
          Color(0xFF7FB77E),
          Color(0xFF5E9C76),
        ];

  bool get _isLowConfidence {
    return _confidence.isNotEmpty && _confidenceValue < 0.55;
  }

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
      _confidenceValue = 0.0;
    });

    final result = await TFLiteHelper.classifyImage(file);

    if (!mounted) return;

    final double confidenceValue =
        double.tryParse(result['confidence'].toString()) ?? 0.0;

    setState(() {
      _result = result['label'].toString();
      _confidenceValue = confidenceValue;
      _confidence = '${(confidenceValue * 100).toStringAsFixed(2)}%';
      _isLoading = false;
    });
  }

  Future<void> _pickCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 900,
      maxHeight: 900,
    );

    if (picked != null) {
      final file = File(picked.path);
      setState(() => _image = file);
      await _runClassification(file);
    }
  }

  Future<void> _pickGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 900,
      maxHeight: 900,
    );

    if (picked != null) {
      final file = File(picked.path);
      setState(() => _image = file);
      await _runClassification(file);
    }
  }

  bool get _hasResult {
    return !_isLoading &&
        _result != 'No result yet' &&
        _result != 'Classifying...';
  }

  void _learnMore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LearnMorePage(
          wasteType: _result,
        ),
      ),
    );
  }

  Widget _customCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? cardColor,
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

  Widget _infoBox() {
    return _customCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: isDarkMode ? Colors.white70 : ReLeafColors.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Upload a clear image of one waste item to get better classification results.',
              style: ReLeafTextStyles.body.copyWith(
                color: subTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBottomTap(int index) {
    if (index == 1) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePageUser()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LocationPage()),
      );
    } else if (index == 3) {
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
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppTopBar(
                title: 'Waste Classification',
                subtitle: 'Take or upload a waste image',
                icon: Icons.camera_alt_outlined,
                showBackButton: false,
                showNotifications: false,
                gradientColors: topBarGradient,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customCard(
                        padding: const EdgeInsets.all(18),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            color: innerCardColor,
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
                                          Icon(
                                            Icons.image_outlined,
                                            color: isDarkMode
                                                ? Colors.white60
                                                : ReLeafColors.textMedium,
                                            size: 54,
                                          ),
                                          const SizedBox(height: 14),
                                          Text(
                                            'Take a photo or upload a waste image',
                                            textAlign: TextAlign.center,
                                            style:
                                                ReLeafTextStyles.body.copyWith(
                                              fontSize: 16,
                                              color: subTextColor,
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
                            child: ReLeafButton(
                              text: 'Take Photo',
                              icon: Icons.camera_alt_outlined,
                              onPressed: _pickCamera,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ReLeafButton(
                              text: 'Upload',
                              icon: Icons.upload_rounded,
                              onPressed: _pickGallery,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _infoBox(),
                      const SizedBox(height: 22),
                      Text(
                        'Result',
                        style: ReLeafTextStyles.title.copyWith(
                          fontSize: 22,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _customCard(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        color: _isLowConfidence
                            ? (isDarkMode
                                ? const Color(0xFF3A2A1B)
                                : const Color(0xFFFFF3E0))
                            : iconBoxColor,
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
                                      color: _isLowConfidence
                                          ? const Color(0xFFE67E22)
                                          : mainTextColor,
                                    ),
                                  ),
                            if (_confidence.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Confidence: $_confidence',
                                style: ReLeafTextStyles.subtitle.copyWith(
                                  color: _isLowConfidence
                                      ? const Color(0xFFE67E22)
                                      : subTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (_isLowConfidence) ...[
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Color(0xFFE67E22),
                                      size: 22,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'We are not fully sure about this result. Please retake the photo to confirm the waste type.',
                                        textAlign: TextAlign.start,
                                        style: ReLeafTextStyles.body.copyWith(
                                          color: const Color(0xFFE67E22),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                      if (_hasResult && !_isLowConfidence) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: ReLeafButton(
                            text: 'Learn More',
                            icon: Icons.info_outline,
                            onPressed: _learnMore,
                          ),
                        ),
                      ],
                      const SizedBox(height: 130),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const UserBottomNav(
          currentIndex: 1,
        ),
      ),
    );
  }
}
