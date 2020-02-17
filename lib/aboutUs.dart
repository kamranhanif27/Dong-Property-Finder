import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(
              child: Text(
                'درباره ما',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text('سازنده برنامه:    محمد کامران حنیف', textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text('شماره تماس:      0093797703506 ', textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text('ایمیل آدرس:      kamranhanif27@gmail.com ', textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Text('نسخه:                1.1.0', textDirection: TextDirection.rtl, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
            )
          ],
        ),
      ),
    );
  }
}
