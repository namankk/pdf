import 'package:flutter/material.dart';
import 'package:pdf_auto_scroll/feature/view/home_screen.dart';

void main() {
  runApp(const PdfAutoScrollApp());
}

class PdfAutoScrollApp extends StatelessWidget {
  const PdfAutoScrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Auto Scroll',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
