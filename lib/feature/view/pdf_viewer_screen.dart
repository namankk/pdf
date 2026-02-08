import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pdf_auto_scroll/core/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath;

  const PdfViewerScreen({super.key, required this.pdfPath});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  Timer? _scrollTimer;

  double _scrollSpeed = 0.2; // supports very slow speed
  bool _isAutoScrolling = false;

  void startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(
      const Duration(milliseconds: 16),
          (_) {
        _pdfController.jumpTo(
          yOffset: _pdfController.scrollOffset.dy + _scrollSpeed,
        );
      },
    );
  }

  void stopAutoScroll() {
    _scrollTimer?.cancel();
  }

  @override
  void dispose() {
    stopAutoScroll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text(
          "Reading",
          style: TextStyle(color: textColor),
        ),
        iconTheme: const IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(
              _isAutoScrolling ? Icons.pause_circle : Icons.play_circle,
              size: 30,
              color: primaryColor,
            ),
            onPressed: () {
              setState(() {
                _isAutoScrolling = !_isAutoScrolling;
                _isAutoScrolling ? startAutoScroll() : stopAutoScroll();
              });
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          // PDF Viewer
          SfPdfViewer.file(
            File(widget.pdfPath),
            controller: _pdfController,
            canShowScrollHead: false,
            canShowScrollStatus: false,
          ),

          // Speed Controller
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF162E26).withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Small drag indicator (glossy detail)
                      Container(
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Text(
                        "Scroll Speed",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${_scrollSpeed.toStringAsFixed(2)} px/frame",
                        style: const TextStyle(
                          color: Color(0xFF1DB954),
                          fontSize: 14,
                        ),
                      ),

                      Slider(
                        value: _scrollSpeed,
                        min: 0.05,
                        max: 10,
                        divisions: 200,
                        activeColor: const Color(0xFF1DB954),
                        inactiveColor:
                        const Color(0xFF1DB954).withValues(alpha: 0.3),
                        onChanged: (value) {
                          setState(() {
                            _scrollSpeed = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   left: 16,
          //   right: 16,
          //   bottom: 20,
          //   child: Container(
          //     padding: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       color: cardColor,
          //       borderRadius: BorderRadius.circular(20),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.3),
          //           blurRadius: 10,
          //         ),
          //       ],
          //     ),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           "Scroll Speed",
          //           style: TextStyle(
          //             color: textColor.withOpacity(0.9),
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //
          //         const SizedBox(height: 8),
          //
          //         Text(
          //           "${_scrollSpeed.toStringAsFixed(2)} px/frame",
          //           style: const TextStyle(
          //             color: primaryColor,
          //             fontSize: 14,
          //           ),
          //         ),
          //
          //         Slider(
          //           value: _scrollSpeed,
          //           min: 0.05,
          //           max: 10,
          //           divisions: 200,
          //           activeColor: primaryColor,
          //           inactiveColor: primaryColor.withOpacity(0.3),
          //           onChanged: (value) {
          //             setState(() {
          //               _scrollSpeed = value;
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
