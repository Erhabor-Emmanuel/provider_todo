import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider_todo_list/constants/url.dart';
import '../../screens/Authentication/login.dart';
import '../../screens/TaskPage/homePage.dart';
import '../../utils/routers.dart';
import 'package:http/http.dart' as http;

import '../TaskProvider/get_task_service.dart';
import '../database/db_provider.dart';

class AuthProvider extends ChangeNotifier{
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/";

    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    print(body);

    try {
      http.Response req =
      await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        print(res);
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        debugPrint(res);
        debugPrint(_resMessage);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/login";

    final body = {
      "email": email,
      "password": password
    };
    print(body);

    try {
      http.Response req =
      await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);


        ///Save users data and then navigate to homepage
        final userId = res['user']['id'];
        final token = res['authToken'];
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);

        debugPrint(userId);
        debugPrint(token);
        debugPrint(res);
        debugPrint(_resMessage);
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        debugPrint(res);
        debugPrint(_resMessage);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

}