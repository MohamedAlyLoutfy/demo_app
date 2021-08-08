import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
enum AuthMode { Signup, Login }
class AuthCard extends StatefulWidget {


  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email':'',
    'phone': '',
    'password': '',
    'username': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();



   Future <void> _submit()async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      await Provider.of<Auth>(context,listen: false).signin(

         _authData['email'],
         _authData['password']    
      );
    } else {
      // Sign user up
     await Provider.of<Auth>(context,listen: false).signup(
        _authData['email'],
         _authData['password']);
    }
    setState(() {
      _isLoading = false;
    });
  }



  //   void validateAndSave() {
  //   final FormState form = _formKey.currentState;
  //   if (form.validate()) {
  //     print('Form is valid');
  //   } else {
  //     print('Form is invalid');
  //   }
  // }
 


  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 500 : 300,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.85,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                if (_authMode == AuthMode.Signup)
                TextFormField(
                  
                  decoration: InputDecoration(labelText: 'Enter Your name'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty ) {
                      return 'please enter your name!';
                    }
                    return null;
                    
                  },
                  onSaved: (value) {
                    _authData['username'] = value;
                  },
                ),

               
                  IntlPhoneField(
                         decoration: InputDecoration(
                                 labelText: 'Phone Number',
                                 border: OutlineInputBorder(
                                 borderSide: BorderSide(),
                             ),  
                             ),
                          initialCountryCode: 'IN',
                         onChanged: (phone) {
                         print(phone.completeNumber);
                         },
                      validator: (value) {
                      if (value.isEmpty ) {
                        return 'please enter a number!';
                      }
                      return null;
                      
                    },
                    onSaved: (value){
                      _authData['phone'] = value.toString();

                    },
                 ),
                 
                  
                  
                


               // if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                    
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: _passwordController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),

                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    validator: _authMode == AuthMode.Signup
                        
                        // ignore: missing_return
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed:_submit ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}