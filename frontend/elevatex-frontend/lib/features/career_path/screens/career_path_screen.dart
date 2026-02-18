import 'package:flutter/material.dart';

class CareerPathSelectionScreen extends StatelessWidget {
  const CareerPathSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A103C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 378,
            padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
                bottom: 96,
            ),
            decoration: BoxDecoration(color: const Color(0xFF1A103C)),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                    // ... (original content)
                ],
            ),
          ),
        ),
      ),
    );
  }
}