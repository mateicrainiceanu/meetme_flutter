import 'package:dio/dio.dart';
import 'package:meetme/providers/api_service.dart';
import 'package:meetme/providers/user_provider.dart';

class AuthUser {
  final String fname;
  final String lname;
  final String email;
  final String username;
  final DateTime dateOfBirth;

  const AuthUser({
    required this.fname,
    required this.lname,
    required this.email,
    required this.username,
    required this.dateOfBirth,
  });

  static AuthUser fromJson(Map<String, dynamic> user) {
    return AuthUser(
      fname: user["fname"],
      lname: user["lname"],
      email: user["email"],
      username: user["username"],
      dateOfBirth: DateTime.parse(user["dateOfBirth"]),
    );
  }

  static Future<bool> usernameIsAvailabile(String uname) async {
    if (uname == UserProvider.instance.user!.username) {
      return true;
    } else {
      final response = await ApiService.instance.request(
        "/username",
        DioMethod.get,
        {"username": uname},
        null,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<Response> updateProfile(String toUpdate, String newValue) {
    return ApiService.instance.request(
      "/user",
      DioMethod.patch,
      null,
      {"toUpdate": toUpdate, "newVal": newValue},
    );
  }

  
}
