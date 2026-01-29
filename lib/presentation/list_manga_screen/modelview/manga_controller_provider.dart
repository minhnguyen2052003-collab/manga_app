import 'package:comic_app_gpt/features/manga/presentation/controller/manga_controller.dart';
import 'package:comic_app_gpt/domain/repository/manga_repository.dart';
import 'package:comic_app_gpt/domain/service/manga_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';

final mangaControllerProvider = Provider<MangaController>(
  (ref) => MangaController(MangaRepository(MangaApi(DioClient.dio))),
);
