import 'package:comic_app_gpt/presentation/cart_creen/view/cart_screen.dart';
import 'package:comic_app_gpt/presentation/favorite_manga_screen/view/list_favorite_manga_screen.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/view/list_manga_screen.dart';
import 'package:comic_app_gpt/presentation/list_manga_screen/widget/app_drawer_widget.dart';
import 'package:comic_app_gpt/presentation/login_screen/modelview/login_controller.dart';
import 'package:comic_app_gpt/presentation/main_screen/modelview/mode_tab_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../list_manga_screen/modelview/state_list_manga_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() {
    return _MainScreenState();
  }
}
class _MainScreenState extends ConsumerState<MainScreen>{
  final controller = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    final loginState  = ref.watch(authControllerProvider);

    final state = ref.watch(stateListMangaProvider);
    final tabState = ref.watch(modeTabScreenProvider);
    String? appBarTitle = state.title;
    if(tabState.mode == ModeTab.cart|| tabState.mode == ModeTab.favorite){
      appBarTitle = tabState.title;
    }else{
      appBarTitle = state.title;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          child: isSearching
              ? TextField(
            controller: controller,
            key: ValueKey("searching"),
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Tìm kiếm....",
              border: InputBorder.none,
            ),
            onChanged: (value) {
              ref
                  .read(stateListMangaProvider.notifier)
                  .loadWithText(value);
            },
            onSubmitted: (value) {
              setState(() {
                appBarTitle = state.title!;
                isSearching = false;
              });
            },
          )
              : Text(
            appBarTitle!,
            key: ValueKey("init"),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  controller.clear();
                  ref
                      .read(stateListMangaProvider.notifier)
                      .loadWithText(controller.text);
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawerWidget(),
      body: switch (tabState.mode) {
        ModeTab.home => const ListMangaScreen(),
        ModeTab.cart => const CartMangaScreen(),
        ModeTab.favorite => const ListFavoriteMangaScreen(),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    ref.read(modeTabScreenProvider.notifier).changeHome();
                  },
                  icon: const Icon(Icons.home),
                  style: IconButton.styleFrom(iconSize: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    ref.read(modeTabScreenProvider.notifier).changeCart();
                  },
                  icon: Icon(Icons.shopping_cart),
                  style: IconButton.styleFrom(
                      iconSize: 24,
                      foregroundColor: Colors.black
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    ref.read(modeTabScreenProvider.notifier).changeFavorite();
                  },
                  icon: const Icon(Icons.star),
                  style: IconButton.styleFrom(
                    iconSize: 24,
                    foregroundColor: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: IconButton(
                  onPressed: () {

                    ref.read(authControllerProvider.notifier).clearAccessToken();



                  },
                  icon: Icon(Icons.person),
                  style: IconButton.styleFrom(
                    iconSize: 24,
                    foregroundColor: Colors.grey,
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