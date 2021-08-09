import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;
    bool get isAuth{
    return token !=null;

  }
 String get token{
         return _token;
    
  }
  String get userId{
    return _userId;
  }
 Future <void> _authenticate(String email,String password,String  urlSegment)async{
    final url='https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBx8DTKG9Dq5xsaMSz7aoxOwtXhJjGoB1c';
    final response=await http.post(Uri.parse(url),
    body: json.encode(
      {
        'email':email,
        'password':password,
        'returnSecureToken':true,
        },
        )
    );
     final responseData=json.decode(response.body);
     //print(responseData);
      _token=responseData['idToken'];
      _userId=responseData['localId'];
      _expiryDate=DateTime.now().add(
           Duration(
              seconds:int.parse(
              responseData['expiresIn']),),);
      notifyListeners();
      final prefs=await SharedPreferences.getInstance();
      final userData=json.encode({'token':_token,'userId':_userId,'expiryDate':_expiryDate.toIso8601String()});
      prefs.setString('userData',userData);
  }



  Future <void> signup(String email,String password) async{
   return _authenticate(email, password, 'signUp');


  }

  Future <void> signin(String email,String password) async{
    return _authenticate(email, password, 'signInWithPassword');


  }
  Future <bool> tryAutoLogin() async {
    final prefs=await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
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
    _token=null;
    _userId=null;
    _expiryDate=null;
  
     notifyListeners();
      final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();

   
  }

}