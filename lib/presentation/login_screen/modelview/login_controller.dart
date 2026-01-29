import 'package:comic_app_gpt/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class LoginController extends StateNotifier<AuthStatus> {
  final AuthRepository authRepository;

  LoginController(this.authRepository) : super(AuthStatus.unknown);

  Future<void> checkAuth() async {
    final token = await authRepository.getAccessToken();
    print(token);
    state = token != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<bool> login(String email, String password) async {
    final success = await authRepository.login(email, password);
    state = AuthStatus.authenticated;
    return success;
  }

  Future<void> clearAccessToken() async {
    await authRepository.clearAccessToken();
    state = AuthStatus.unauthenticated;

  }
}

final authControllerProvider =
    StateNotifierProvider<LoginController, AuthStatus>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return LoginController(repo);
    });
