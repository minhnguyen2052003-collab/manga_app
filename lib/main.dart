import 'package:comic_app_gpt/screens/list_manga_screen.dart';
import 'package:flutter/material.dart';
import 'models/poster_image.dart';
import 'package:comic_app_gpt/screens/list_manga_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comics App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const ListMangaScreen(),
    );
  }
}