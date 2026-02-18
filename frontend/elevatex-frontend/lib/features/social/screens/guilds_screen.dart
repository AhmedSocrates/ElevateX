import 'package:flutter/material.dart';

class GuildsScreen extends StatelessWidget {
  const GuildsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A103C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 394,
            height: 852,
            decoration: BoxDecoration(color: const Color(0xFF1A103C)),
            child: Stack(
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