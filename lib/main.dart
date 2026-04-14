import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'admin/AdminBinManagment.dart';
void main() {
=======
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

>>>>>>> 6f86ec77353f629cb07cc961dd574a81b42babf0
  runApp(const ReLeafApp());
}

class ReLeafApp extends StatelessWidget {
  const ReLeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReLeaf',
      home: const AdminBinManagment(),
    );
  }
}
