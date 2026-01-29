import 'package:comic_app_gpt/domain/repository/auth_repository.dart';
import 'package:comic_app_gpt/presentation/login_screen/modelview/login_controller.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/view/list_manga_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerStatefulWidget {


  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Username / Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập email/ username";
                      }
                      return null;
                    },

                  ),
                  TextFormField(
                    controller: passwordCtrl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if(!_formKey.currentState!.validate()) return;
                try{
                  final success = await ref.read(authControllerProvider.notifier).login(usernameCtrl.text, passwordCtrl.text);
                  if(success){
                    return;
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sai tài khoản hoặc mật khẩu")));
                  }
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lỗi đăng nhập")));
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: openKitsuSignup, child: const Text("Signup"))
          ],
        ),
      ),
    );
  }
}
Future<void> openKitsuSignup() async {
  final Uri uri = Uri.parse('https://kitsu.io/signup');

  final bool success = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  if (!success) {
    print('Không thể mở trình duyệt');
  }
}
