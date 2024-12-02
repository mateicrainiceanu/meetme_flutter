import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meetme/models/auth_user.dart';
import 'package:meetme/providers/api_service.dart';

enum LoginState { loading, failed, success }

class UserProvider extends ChangeNotifier {
  //initalize user for the provider
  UserProvider._singleton() {
    initialiseUser();
  }

  String? _token;
  String? get token => _token;

  set token(String? value) {
    const FlutterSecureStorage().write(key: "token", value: value!);
  }

  LoginState _loginState = LoginState.loading;
  LoginState get loginState => _loginState;

  AuthUser? _user;
  AuthUser? get user => _user;

  static final UserProvider instance = UserProvider._singleton();

  Future<void> getTokenFromStorage() async {
    _token = await const FlutterSecureStorage().read(key: "token");
  }

  Future<void> initialiseUser() async {
    await getTokenFromStorage();
    if (_token != null) {
      await fetchUserData();
    } else {
      _loginState = LoginState.failed;
    }
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    if (_token == null) {
      _loginState = LoginState.failed;
      notifyListeners();
      return;
    }

    ApiService.instance.token = _token;

    final response = await ApiService.instance.request(
      "/user",
      DioMethod.get,
      null,
      null,
    );

    if (response == null) {
      _loginState = LoginState.failed;
      notifyListeners();
      return;
    }

    if (response.statusCode != 200 || response.data == null) {
      _loginState = LoginState.failed;
      notifyListeners();
      return;
    } else {
      try {
        _user = AuthUser.fromJson(response.data);
        print(_user);
        if (_user == null) {
          _loginState = LoginState.failed;
          notifyListeners();
          return;
        }
      } on Exception {
        _loginState = LoginState.failed;
        notifyListeners();
        return;
      }
      _loginState = LoginState.success;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    final response = await ApiService.instance.request(
      "/login",
      DioMethod.post,
      null,
      {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("An error occurred");
    }

    final token = response.data["token"];
    ApiService.instance.token = token;
    _token = token;

    _user = AuthUser.fromJson(response.data["user"]);
    _loginState = LoginState.success;
    ApiService.instance.token = token;

    notifyListeners();
  }

  Future<void> register(
      String fname, String lname, String email, String password) async {
    final response = await ApiService.instance.request(
      "/register",
      DioMethod.post,
      null,
      {
        "fname": fname,
        "lname": lname,
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("An error occurred");
    }

    final token = response.data["token"];
    ApiService.instance.token = token;
    _token = token;

    _user = AuthUser.fromJson(response.data["user"]);
    _loginState = LoginState.success;

    notifyListeners();
  }

  void logout() {
    _loginState = LoginState.failed;
    _token = null;
    _user = null;
    ApiService.instance.token = null;
    notifyListeners();
  }
}
