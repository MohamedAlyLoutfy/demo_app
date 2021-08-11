import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment, String phone) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBx8DTKG9Dq5xsaMSz7aoxOwtXhJjGoB1c';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true,
            },
          ));
      //print(phone);
      final responseData = json.decode(response.body);
      //print(responseData);
      if (urlSegment == 'signInWithPassword') {
        var a = await onlogin(
            phone, responseData['idToken'], responseData['localId']);
        if (a == 'wrong') {
          print('wrong number');
          return;
        }
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );

      if (urlSegment == 'signUp') {
        onregister(password, phone);
      }

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String phone) async {
    return _authenticate(email, password, 'signUp', phone);
  }

  Future<void> signin(String email, String password, String phone) async {
    return _authenticate(email, password, 'signInWithPassword', phone);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<void> onregister(String password, String phone) async {
    final url =
        'https://demoapp-90b94-default-rtdb.firebaseio.com/users.json?auth=$_token';

    await http.post(Uri.parse(url),
        body: json
            .encode({'userid': _userId, 'phone': phone, 'password': password}));
  }

  Future<String> onlogin(String phone, String token, String userId) async {
    final filterString = 'orderBy="userid"&equalTo="$userId"';
    final url =
        'https://demoapp-90b94-default-rtdb.firebaseio.com/users.json?auth=$token&$filterString';

    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //print(extractedData);
    String a;
    extractedData.forEach((prodId, prodData) {
      //print(prodData['phone']);
      if (prodData['phone'].toString() == phone) {
        // print('correct');
        a = 'correct';
      } else {
        // print('wrong');
        a = 'wrong';
      }
    });
    return a;
  }
}
