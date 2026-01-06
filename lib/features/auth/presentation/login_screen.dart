import 'package:comic_app_gpt/features/auth/data/auth_repository.dart';
import 'package:comic_app_gpt/features/auth/presentation/login_controller.dart';
import 'package:comic_app_gpt/features/manga/presentation/screen/list_manga_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget{
  

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen>{

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username / Email'),
            ),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await ref.read(authControllerProvider.notifier).login(
                  usernameCtrl.text,
                  passwordCtrl.text,
                );
                if(success){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListMangaScreen()));
                }
                print('LOGIN SUCCESS');
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}