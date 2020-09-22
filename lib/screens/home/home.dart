import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:polkadot_app/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();

  AnimationController _animationController;

  Animation<Color> _coloranimation;

  double _margin = 20;

  double _opacity = 1;

  double _width = 200;

  double _height = 600;

  Color _color = Colors.tealAccent;

  bool is_fave = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animationController.forward();
    _animationController.addListener(() {
      print(_animationController.value);
    });

    _coloranimation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          is_fave = true;
        });
      } else {
        setState(() {
          is_fave = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Polkadot'),
          backgroundColor: Colors.pink[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          width: 360,
          height: 640,
          child: Stack(children: <Widget>[
            Positioned(
              top: 2,
              left: 12,
              //width: 40,
              //height: 50,
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                margin: EdgeInsets.all(_margin),
                width: _width,
                color: _color,
                height: _height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("animate margin"),
                      onPressed: () {
                        setState() {
                          _margin = 100;
                          _color = Colors.purple;
                          print("clciked");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 4,
              child: TweenAnimationBuilder(
                child: Text(
                  "hello world",
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.pink
                      fontWeight: FontWeight.bold),
                ),
                duration: Duration(milliseconds: 9000),
                builder: (BuildContext context, double val, Widget child) {
                  return Opacity(
                      opacity: val,
                      child: Padding(
                        child: child,
                        padding: EdgeInsets.only(top: val),
                      ));
                },
                tween: Tween<double>(begin: 0, end: 1),
              ),
            ),
            Positioned(
                top: 300,
                left: 40,
                child: Stack(
                  children: [
                    Positioned(
                      child: Text(
                        "we will rock you",
                        style: TextStyle(color: _coloranimation.value),
                      ),
                    ),
                    Positioned(
                      child: FlatButton(
                        child: Text(
                          "press this",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          is_fave
                              ? _animationController.reverse()
                              : _animationController.forward();
                        },
                      ),
                    )
                  ],
                ))
          ]),
        ));
  }
}
