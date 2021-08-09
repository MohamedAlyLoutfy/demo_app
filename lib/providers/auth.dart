import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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
    notifyListeners();
   

  }


  Future <void> signup(String email,String password) async{
   return _authenticate(email, password, 'signUp');


  }

  Future <void> signin(String email,String password) async{
    return _authenticate(email, password, 'signInWithPassword');


  }

  void logout(){
    print('here');
    _token=null;
    _userId=null;
    //_expiryDate=null;
    notifyListeners();
  }

}