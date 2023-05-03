import 'dart:async';

import 'package:av_app/pages/AdministrationPage.dart';
import 'package:av_app/pages/PlayingPage.dart';
import 'package:av_app/pages/MapPage.dart';
import 'package:av_app/services/DataService.dart';
import 'package:av_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'pages/LoginPage.dart';
import 'styles/Styles.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://jyghacisbuntbrshhhey.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp5Z2hhY2lzYnVudGJyc2hoaGV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODIxMjAyMjksImV4cCI6MTk5NzY5NjIyOX0.SLVxu1YRl2iBYRqk2LTm541E0lwBiP4FBebN8PS0Rqg',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PageNames.HOME_PAGE,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'RussoOne',
          secondaryHeaderColor: const Color(0xFFBA5D3F),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch)
              .copyWith(background: backgroundColor)),
      home: const MyHomePage(title: PageNames.HOME_PAGE),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String futureProgram = "loading...";

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    DataService.tryAuthUser().then((loggedIn) {
      setState(() {
        isLoggedIn = loggedIn;
      });
    });
    DataService.getFirstProgramTitle().then((fp) {
      setState(() {
        futureProgram = fp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: SvgPicture.asset(
                width: 250,
                semanticsLabel: 'Absolventský Velehrad',
                'assets/images/avlogo.svg',
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MainPageButton(
                      onPressed: _programPressed,
                      backgroundColor: primaryBlue1,
                      child: const Icon(Icons.calendar_month),
                    ), // <-- Icon
                    const Text("Program"), // <-- Text
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MainPageButton(
                      onPressed: _programPressed,
                      backgroundColor: primaryYellow,
                      child: const Icon(Icons.newspaper),
                    ), // <-- Icon
                    const Text("Ohlášky"), // <-- Text
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MainPageButton(
                      onPressed: _mapPressed,
                      backgroundColor: primaryRed,
                      child: const Icon(Icons.map),
                    ), // <-- Icon
                    const Text("Mapa"), // <-- Text
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    MainPageButton(
                      onPressed: _infoPressed,
                      backgroundColor: primaryBlue2,
                      child: const Icon(Icons.info),
                    ), // <-- Icon
                    const Text("Info"), // <-- Text
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isLoggedIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MainPageButton(
                        onPressed: _loginPressed,
                        backgroundColor: primaryBlue2,
                        child: const Icon(Icons.login),
                      ), // <-- Icon
                      const Text("Přihlášení"), // <-- Text
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoggedIn,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MainPageButton(
                        onPressed: _logout,
                        backgroundColor: primaryBlue2,
                        child: Icon(Icons.logout),
                      ), // <-- Icon
                      Text("Odhlásit se"), // <-- Text
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 48.0),
              child: Text(futureProgram))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _programPressed() {
    Fluttertoast.showToast(msg: ("any button was pressed"));
  }

  void _infoPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AdministrationPage()));
  }

  void _mapPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MapPage()));
  }

  void _loginPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void _logout() {
    DataService.logout();
    setState(() {
      isLoggedIn = false;
    });
  }
}
