import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'SplashScreen.dart';
import 'classification/tflite_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await TFLiteHelper.init();

  runApp(const ReLeafApp());
}

class NoStretchScrollBehavior extends ScrollBehavior {
  const NoStretchScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // Android style
  }
}

class ReLeafApp extends StatelessWidget {
  const ReLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReLeaf',
      scrollBehavior: const NoStretchScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
    );
  }
}
