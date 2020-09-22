import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polkadot_app/services/auth.dart';
import 'package:polkadot_app/shared/constants.dart';
import 'package:polkadot_app/shared/loading.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listofBiometrics;

    try {
      listofBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listofBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;

    try {
      var isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "please authenticate to sign in",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  //test feild state
  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.pink[300],
              elevation: 0.0,
              title: Text(
                'Polkadot',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.white),
                  label:
                      Text('Register', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.length < 6 ? 'Enter Email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            // obscure is for password
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.signInEmailAndPass(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "please supply a valid email";
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Can we check Biometric: $_canCheckBiometric"),
                              RaisedButton(
                                onPressed: _checkBiometric,
                                child: Text("Check Biometric"),
                                color: Colors.pink[300],
                                colorBrightness: Brightness.light,
                              ),
                              Text(
                                  "List of Biometric: ${_availableBiometricTypes.toString()}"),
                              RaisedButton(
                                onPressed: _getListOfBiometricTypes,
                                child: Text("List of Biometric Types"),
                                color: Colors.pink[300],
                                colorBrightness: Brightness.light,
                              ),
                              Text(" Authorized: ${_authorizedOrNot}"),
                              RaisedButton(
                                onPressed: _authorizeNow,
                                child: Text("Authorized now"),
                                color: Colors.pink[300],
                                colorBrightness: Brightness.light,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            error,
                            style: TextStyle(
                                color: Colors.pink[300], fontSize: 14.0123),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text('Sign in Anonymus'),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnom();
                        if (result == null) {
                          print('Error sign in');
                        } else {
                          print('Sign in');
                          print(result.uid);
                        }
                        //result!=null?
                      },
                    ),
                  ],
                )),
          );
  }
}
