
import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/social/screens/guild_info/guild_info_detailsdart';
import 'package:flutter/material.dart';

class GuildInfoScreen extends StatelessWidget {
  const GuildInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 394,
            height: 852,
            decoration: BoxDecoration(color: AppColors.background),
            child: const GuildInfoDetailsView(),
          ),
        ),
      ),
    );
  }
}
