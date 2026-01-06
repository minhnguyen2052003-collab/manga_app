import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final Dio dio;

  AuthService(this.dio);

  Future<Map<String, dynamic>> login(String email, String password) async{

    final response = await dio.post(
      "/oauth/token",
        options: Options(
          contentType: Headers.formUrlEncodedContentType,),
      data: {
        "grant_type": "password",
        "username": email,
        "password": password,
      },

    );

    return response.data;
  }
}
