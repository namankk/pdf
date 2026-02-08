import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'pdf_viewer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> pickPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PdfViewerScreen(
            pdfPath: result.files.single.path!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Icon
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF162E26),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  size: 64,
                  color: Color(0xFF1DB954),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                "PDF Auto Scroll Reader",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6F4EF),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                "Read PDFs hands-free with adjustable auto scrolling",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF9FBFB5),
                ),
              ),

              const SizedBox(height: 48),

              // Open PDF Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () => pickPdf(context),
                  icon: const Icon(Icons.upload_file_rounded),
                  label: const Text(
                    "Open PDF",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DB954),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Privacy Text
              const Text(
                "Your PDF stays on your device.\nWe don’t upload or store files.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7FA99F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
