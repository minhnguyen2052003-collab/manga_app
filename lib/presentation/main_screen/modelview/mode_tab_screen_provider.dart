import 'package:flutter_riverpod/legacy.dart';

enum ModeTab { home, cart, favorite }

class TabState {
  ModeTab mode;
  String title;

  TabState({required this.title, required this.mode});

  factory TabState.initial() {
    return TabState(title: "Danh sách truyện", mode: ModeTab.home);
  }

  TabState copyWith({ModeTab? mode, String? title}) {
    return TabState(title: title ?? this.title, mode: mode ?? this.mode);
  }
}

class ModeTabScreenProvider extends StateNotifier<TabState> {
  ModeTabScreenProvider() : super(TabState.initial());

  void changeCart() {
    state = state.copyWith(mode: ModeTab.cart, title: "Giỏ hàng");
    // state = ModeTab.cart;
  }

  void changeFavorite() {
    state = state.copyWith(mode: ModeTab.favorite, title: "Yêu thích");
    // state = ModeTab.favorite;
  }

  void changeHome() {
    state = state.copyWith(mode: ModeTab.home, title: "Danh sách truyện");
    // state = ModeTab.home;
  }
}

final modeTabScreenProvider =
    StateNotifierProvider<ModeTabScreenProvider, TabState>(
      (ref) => ModeTabScreenProvider(),
    );
