import 'dart:math';

import 'package:comic_app_gpt/domain/repository/manga_local_repository.dart';
import 'package:comic_app_gpt/domain/service/manga_local_data.dart';
import 'package:comic_app_gpt/utils/Manga.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

class MangaLocalController extends StateNotifier<bool>{
  final MangaLocalRepository mangaLocalRepository;
  final int id;
  MangaLocalController(this.mangaLocalRepository,this.id) : super(mangaLocalRepository.exist(id));


  Future<void> toggle(Manga manga, int id) async {
    if(state){
      await mangaLocalRepository.delete(id);
      state = false;


    }else{
      await mangaLocalRepository.saveManga(manga);
      state = true;
    }
  }


}

final mangaLocalController = StateNotifierProvider.family<MangaLocalController,bool,int>((ref, mangaId){
  final box = Hive.box<Manga>('mangaBox');
  return MangaLocalController(MangaLocalRepository(MangaLocalData(box)), mangaId);
});