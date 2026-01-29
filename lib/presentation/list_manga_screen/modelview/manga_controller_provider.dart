import 'package:comic_app_gpt/presentation/list_manga_screen/modelview/manga_controller.dart';
import 'package:comic_app_gpt/domain/repository/manga_repository.dart';
import 'package:comic_app_gpt/data/manga_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/dio_client.dart';

final mangaControllerProvider = Provider<MangaController>(
  (ref) => MangaController(MangaRepository(MangaApi(DioClient.dio))),
);
