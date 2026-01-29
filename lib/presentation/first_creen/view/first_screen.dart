import 'package:comic_app_gpt/presentation/login_screen/modelview/login_controller.dart';
import 'package:comic_app_gpt/presentation/login_screen/view/login_screen.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/view/list_manga_screen.dart';
import 'package:comic_app_gpt/presentation/main_screen/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authControllerProvider.notifier).checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    switch (authState) {
      case AuthStatus.unknown:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthStatus.authenticated:
        return const MainScreen();
      case AuthStatus.unauthenticated:
        return const LoginScreen();
    }
  }
}
