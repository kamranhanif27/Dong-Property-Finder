import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './aboutUs.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isLoggedIn = false;
  bool progressBar = true;
  FirebaseUser _user;

  void initState () {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged
        .firstWhere((user) => user != null)
          .then((user) {
          setState(() {
            isLoggedIn = true;
            _user = user;
          });
        });
    Future.delayed(const Duration(milliseconds: 100),(){
      setState(() {
        progressBar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(
              child: Text(
                'بیشتر',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: progressBar ? Center(child: CircularProgressIndicator(),) : Column(
        children: <Widget>[
          isLoggedIn ? Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 20.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    _user.phoneNumber,
                    style: TextStyle(fontFamily: 'Robot', fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ) : Container(
              height: 70.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  )),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.red.shade400,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
                child: Text('ورود / ثبت نام', style: TextStyle(color: Colors.white, fontSize: 18.0),),
              ),
              ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: InkWell(
              onTap: () {
                launch("tel://+93797703506");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(Icons.phone),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'تماس با ما',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AboutUs()
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(Icons.supervised_user_circle),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'درباره ما',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
//          Container(
//            decoration: BoxDecoration(
//                color: Colors.grey.shade100,
//                border: Border(
//                  bottom: BorderSide(width: 1.0, color: Colors.grey),
//                )),
//            child: InkWell(
//              onTap: () {},
//              child: Padding(
//                padding: const EdgeInsets.symmetric(
//                    vertical: 20.0, horizontal: 15.0),
//                child: Row(
//                  textDirection: TextDirection.rtl,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Row(
//                      textDirection: TextDirection.rtl,
//                      children: <Widget>[
//                        Icon(Icons.share),
//                        SizedBox(
//                          width: 25.0,
//                        ),
//                        Text(
//                          'اشتراک گذاری اپلیکشن',
//                          style: TextStyle(
//                              fontSize: 18.0,
//                              fontWeight: FontWeight.w500,
//                              color: Colors.black),
//                        )
//                      ],
//                    ),
//                    Icon(
//                      Icons.arrow_back_ios,
//                      size: 14.0,
//                      color: Colors.grey,
//                    )
//                  ],
//                ),
//              ),
//            ),
//          ),
//          Container(
//            decoration: BoxDecoration(
//                color: Colors.grey.shade100,
//                border: Border(
//                  bottom: BorderSide(width: 1.0, color: Colors.grey),
//                )),
//            child: InkWell(
//              onTap: () {},
//              child: Padding(
//                padding: const EdgeInsets.symmetric(
//                    vertical: 20.0, horizontal: 15.0),
//                child: Row(
//                  textDirection: TextDirection.rtl,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Row(
//                      textDirection: TextDirection.rtl,
//                      children: <Widget>[
//                        Icon(Icons.refresh),
//                        SizedBox(
//                          width: 25.0,
//                        ),
//                        Text(
//                          'بروز رسانی اپلیکشن',
//                          style: TextStyle(
//                              fontSize: 18.0,
//                              fontWeight: FontWeight.w500,
//                              color: Colors.black),
//                        )
//                      ],
//                    ),
//                    Icon(
//                      Icons.arrow_back_ios,
//                      size: 14.0,
//                      color: Colors.grey,
//                    )
//                  ],
//                ),
//              ),
//            ),
//          ),
          isLoggedIn ? Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          height: 80,
                          child: Center(
                            child: Text('آیا میخواهید از حساب کاربری خود خارج شوید؟'),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('تایید'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              FirebaseAuth.instance.signOut();
                              setState(() {
                                isLoggedIn = false;
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('لغو'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 15.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.signOutAlt),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          'خروج',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
