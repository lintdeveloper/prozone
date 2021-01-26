import 'package:flutter/material.dart';
import 'package:prozone/application.dart';
import 'package:prozone/screens/screens.dart';

import 'models/token__model.dart';

class AppSetter extends StatefulWidget {
  @override
  _AppSetterState createState() => _AppSetterState();
}

class _AppSetterState extends State<AppSetter>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  bool isToken;

  @override
  void initState() {
    super.initState();
    setUpAnimation();
    saveToken();
    checkUser();
  }

  setUpAnimation() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
  }

  checkUser() async {
    final application = Application.instance();
    final token = await application.getAuthToken();
    String _token;

    if (mounted) {
      await Future.delayed(Duration(milliseconds: 1500), () async {
        if (token) {
          print("Token");
          print(token);
          await application.getToken("authToken").then((token) {
            _token = token["value"];
          });
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (Route<dynamic> route) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          //alignment: Alignment.topCenter,
          //fit: StackFit.expand,
          children: <Widget>[
            Container(
                // color: APP_COLOR,
                ),
            Center(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void saveToken() async {
    final application = Application.instance();
    Token token = Token("token",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwNzI4MjAzLCJleHAiOjE2MTMzMjAyMDN9.7TKlfBKkf8jw9FPjo91z7gQxvLB21ycXphEkH6-_Cc0");
    await application.setAuthToken("authToken", token.toJson());
  }
}
