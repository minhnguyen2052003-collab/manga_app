import 'package:comic_app_gpt/domain/repository/cart_repository.dart';
import 'package:comic_app_gpt/domain/service/cart_data_local.dart';
import 'package:comic_app_gpt/domain/usecase/add_to_cart.dart';
import 'package:comic_app_gpt/domain/usecase/get_cart_items.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_bloc.dart';
import 'package:comic_app_gpt/presentation/cart_creen/bloc/cart_event.dart';
import 'package:comic_app_gpt/presentation/first_creen/view/first_screen.dart';
import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:comic_app_gpt/utils/manga_attribute.dart';
import 'package:comic_app_gpt/utils/poster_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MangaAdapter());
  Hive.registerAdapter(MangaAttributesAdapter());
  Hive.registerAdapter(PosterImageAdapter());

  await Hive.openBox<Manga>('mangaBox');
  await Hive.openBox<Manga>("cartBox");

  runApp(
    ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) {
              final box = Hive.box<Manga>("cartBox");
              final repo = CartRepositoryImpl(CartData(box));
              return CartBloc(
                addComicToCartUseCase: AddToCartUseCase(repo),
                getCartUseCase: GetCartUseCase(repo),
              )..add(LoadCart());
            },
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
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
      home: FirstScreen(),
    );
  }
}
