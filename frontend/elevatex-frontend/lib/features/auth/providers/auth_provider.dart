import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    // Initial state: not logged in
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    state = AsyncData(UserModel(
      id: '1',
      name: 'Ahmed Socrates',
      level: 12,
      totalXp: 12500,
      currentStreak: 7,
    ));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = const AsyncData(null);
  }
}
