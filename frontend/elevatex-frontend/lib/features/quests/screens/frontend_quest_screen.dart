import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quest_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_surface_card.dart';

class FrontendQuestScreen extends ConsumerWidget {
  const FrontendQuestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(questProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Frontend Quests', style: AppTextStyles.h3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: questsAsync.when(
        data: (quests) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quests.length,
          itemBuilder: (context, index) {
            final quest = quests[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            quest.title,
                            style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (quest.isCompleted)
                          const Icon(Icons.check_circle, color: Colors.green)
                        else
                          Text(
                            '+${quest.xpReward} XP',
                            style: AppTextStyles.label.copyWith(color: AppColors.accentGold),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(quest.description, style: AppTextStyles.bodySm),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: AppTextStyles.bodyMd),
        ),
      ),
    );
  }
}