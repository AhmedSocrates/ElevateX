import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_header.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_highlight_card.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_list_card.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_models.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_scope_toggle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuildRankingScreen extends StatefulWidget {
  const GuildRankingScreen({super.key});

  @override
  State<GuildRankingScreen> createState() => _GuildRankingScreenState();
}

class _GuildRankingScreenState extends State<GuildRankingScreen> {
  GuildRankingScope _selectedScope = GuildRankingScope.global;

  List<GuildRankingEntry> get _entries {
    return _selectedScope == GuildRankingScope.global
        ? GuildRankingData.global
        : GuildRankingData.friends;
  }

  // GuildRankingEntry get _highlightedUser {
  //   for (final GuildRankingEntry entry in _entries) {
  //     if (entry.isCurrentUser) {
  //       return entry;
  //     }
  //   }
  //   return _entries.first;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GuildRankingHeader(onBackTap: () => context.pop()),
              const SizedBox(height: 24),
              GuildRankingScopeToggle(
                selectedScope: _selectedScope,
                onScopeChanged: (GuildRankingScope scope) {
                  setState(() {
                    _selectedScope = scope;
                  });
                },
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return GuildRankingListCard(entry: _entries[index]);
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Rankings update daily at midnight',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textBody,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
