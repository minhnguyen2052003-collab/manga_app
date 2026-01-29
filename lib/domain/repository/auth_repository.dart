
import 'package:comic_app_gpt/domain/service/auth_service.dart';
import 'package:comic_app_gpt/domain/service/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_interceptor.dart';
import '../../data/dio_client.dart';

class AuthRepository {
  final AuthService authService;
  late final LocalStorageService localStorageService;
  final AuthInterceptor authInterceptor;

  AuthRepository(this.authService, this.localStorageService,this.authInterceptor);

  Future<bool> login(String email, String password)async{
    final data = await authService.login(email, password);
    final accessToken = data["access_token"] as String?;
    final refreshToken = data["refresh_token"] as String?;
    if(accessToken!=null){
      await localStorageService.setAccessToken(accessToken);
    }

    if(refreshToken != null) {
      await localStorageService.saveRefreshToken(refreshToken);
    }

    authInterceptor.upDateToken(accessToken!);
    return true;

  }


  Future<String?> getAccessToken() {
    return localStorageService.getAccessToken();
  }

  Future<void> clearAccessToken()async{
    await localStorageService.clearAccessToken();

  }


}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = AuthService(DioClient.dio);
  final localStorage = ref.read(localStorageProvider);
  final auInterceptor = AuthInterceptor();

  return AuthRepository(authService,localStorage,auInterceptor);
});