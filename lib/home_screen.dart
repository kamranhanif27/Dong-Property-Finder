import 'dart:async';
import 'package:Dong/my_ads.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './add_ad_screen.dart';
import './profile_screen.dart';

import './property_list.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Key propertyListKey = PageStorageKey('propertyListKey');
  final PageStorageBucket bucket = PageStorageBucket();


  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => check());
  }
  bool isOffline = false;
  int _selectedPage = 3;
  final _pageOptions = [
    ProfileScreen(),
    MyAds(),
    AddAdScreen(),
    Column(
      children: <Widget>[
        Expanded(
            child: PropertyList(key: propertyListKey,)
        ),
      ],
    ),
  ];


  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isOffline = false;
      });
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isOffline = false;
      });
      return false;
    }
    setState(() {
      isOffline = true;
    });
    return true;
  }



  DateTime currentBackPressTime = DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)){
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'برای خارج شدن کلید عقب را دوباره کلید نمایید',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black.withOpacity(0.3),
        textColor: Colors.white,
        fontSize: 12.0
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return WillPopScope(child: (isOffline) ? new Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.network_check, size: 76.0,color: Colors.deepOrange,),
              SizedBox(height: 15.0,),
              Text('لطفا به شبکه متصل شوید!', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ) : new Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.grey.shade300,
            width: double.infinity,
            height: double.infinity,
            child: PageStorage(
              child: _pageOptions[_selectedPage],
              bucket: bucket,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(

          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          fixedColor: Colors.redAccent,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 3.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('بیشتر')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.note),
                title: Text('آگهی های من')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                title: Text('ثبت آگهی')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('جستجو')
            ),
          ],
        ),
      ), onWillPop: onWillPop,);
    }

}
