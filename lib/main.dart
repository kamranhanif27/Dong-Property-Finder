import 'package:Dong/my_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.red,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder> {
        '/homepage': (BuildContext context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Dong',
      theme: ThemeData(
        fontFamily: 'Far Diplomat',
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}


