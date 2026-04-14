import 'package:flutter/material.dart';
import 'admin/AdminBinManagment.dart';
void main() {
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
