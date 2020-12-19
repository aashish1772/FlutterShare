import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttershare/pages/activity_feed_screen.dart';
import 'package:fluttershare/pages/profile_screen.dart';
import 'package:fluttershare/pages/search_screen.dart';
import 'package:fluttershare/pages/timeline_screen.dart';
import 'package:fluttershare/pages/upload_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAuth = true;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _googleSignIn.onCurrentUserChanged.listen((user) {
      print(user);
      if (user != null) {
        setState(() {
          _isAuth = true;
        });
      } else {
        setState(() {
          _isAuth = false;
        });
      }
    }).onError((err) {
      print("Error occured $err");
    });
    _googleSignIn.signInSilently(suppressErrors: false).then((user) {
      print(user);
      if (user != null) {
        setState(() {
          _isAuth = true;
        });
      } else {
        setState(() {
          _isAuth = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void logIn() {
    _googleSignIn.signIn();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  onButtonChange(int pageIndex) {
    // No setState required??
    _pageIndex = pageIndex;
    _pageController.animateToPage(_pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ]),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'FlutterShare',
              style: TextStyle(
                fontSize: 70,
                color: Colors.white,
                fontFamily: "Signatra",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => logIn(),
                child: Container(
                  height: 50,
                  width: 260,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/google_signin_button.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [Timeline(), Search(), Upload(), ActivityFeed(), Profile()],
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).accentColor,
        onTap: onButtonChange,
        currentIndex: _pageIndex,
        backgroundColor: Colors.grey[350],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'Timeline', icon: Icon(Icons.timeline)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              label: 'Upload', icon: Icon(Icons.cloud_upload_rounded)),
          BottomNavigationBarItem(
              label: 'Notifications',
              icon: Icon(Icons.notifications_active_outlined)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
