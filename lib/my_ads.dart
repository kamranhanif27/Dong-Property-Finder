import 'dart:convert';
import 'dart:io';

import 'package:Dong/filter_result.dart';
import 'package:Dong/property_detail.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {

  Future<List<Property>> _getProperties() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid.toString();
    var data = await http.get("http://axisjustice.com/dong/dong.php?user_id=\"$uid\"");
    var jsonData = json.decode(data.body);
    List<Property> properties = [];
    for (var p in jsonData) {
      Property property = Property(
          p['id'],
          p['user_id'],
          p['title'],
          p['propertyType'],
          p['adType'],
          p['area'],
          p['length'],
          p['width'],
          p['beds'],
          p['builtYear'],
          p['price'],
          p['address'],
          p['province'],
          p['details'],
          p['image'],
          p['name'],
          p['phoneNumber'],
          p['package']);
      properties.add(property);
    }
    return properties;
  }

  @override
  void initState() {
    super.initState();
    Admob.initialize(getAppId());
  }

  String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-8827475189355024~9977218752';
    }
    return null;
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-8827475189355024/9698017157';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 1.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(
              child: Text(
                'آگهی های من',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getProperties(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData &&
                snapshot.data != null){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if(index % 10 != 3) return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: InkWell(
                        onTap: () {
                          print(snapshot.data[index].image                                                                                                                  );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetail(
                                id: snapshot.data[index].id,
                                userId: snapshot.data[index].userId,
                                address: snapshot.data[index].address,
                                province: snapshot.data[index].province,
                                adType: snapshot.data[index].adType,
                                area: snapshot.data[index].area,
                                beds: snapshot.data[index].beds,
                                builtYear: snapshot.data[index].builtYear,
                                details: snapshot.data[index].details,
                                image: snapshot.data[index].image,
                                name: snapshot.data[index].name,
                                title: snapshot.data[index].title,
                                price: snapshot.data[index].price,
                                propertyType: snapshot.data[index].propertyType,
                                phoneNumber: snapshot.data[index].phoneNumber,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 350.0,
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                FadeInImage.assetNetwork(
                                  fit: BoxFit.fill,
                                  height: 200.0,
                                  placeholder: 'assets/image/image-placeholder.jpg',
                                  image: 'http://axisjustice.com/dong/images/' + snapshot.data[index].userId + '/' + snapshot.data[index].image.toString().split(',').elementAt(0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton(
                                              child: Text('حذف آگهی', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),),
                                              onPressed: () async{
                                                print(snapshot.data[index].id);
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                    context,
                                                    '/homepage',
                                                        (_) => false);
                                                await http.delete("http://axisjustice.com/dong/dong.php?id=${snapshot.data[index].id}");
                                              },
                                              color: Colors.red,
                                            ),
                                            Text(
                                              '${snapshot.data[index].title}',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          '${snapshot.data[index].price} افغانی',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(fontSize: 22.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(width: 10.0,),
                                            snapshot.data[index].propertyType == 'خانه' || snapshot.data[index].propertyType == 'آپارتمان' ? Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: <Widget>[
                                                Text(
                                                  "${snapshot.data[index].beds}",
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(fontSize: 20.0),
                                                ),
                                                SizedBox(width: 10.0,),
                                                Icon(FontAwesomeIcons.bed, size: 26.0, color: Colors.deepOrange,)
                                              ],
                                            ) : Container(),
                                            SizedBox(width: 10.0,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: <Widget>[
                                                Text(
                                                  "${snapshot.data[index].area} متر ",
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(fontSize: 22.0),
                                                ),
                                                SizedBox(width: 5.0,),
                                                Icon(FontAwesomeIcons.rulerVertical, size: 26.0, color: Colors.deepOrange,)
                                              ],
                                            ),
                                            SizedBox(width: 10.0,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: <Widget>[
                                                Text(
                                                  "${snapshot.data[index].province}",
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(fontSize: 22.0),
                                                ),
                                                SizedBox(width: 5.0,),
                                                Icon(Icons.location_on, size: 26.0, color: Colors.deepOrange,)
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ); else return Card(
                      elevation: 2.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: AdmobBanner(
                          adUnitId: getBannerAdUnitId(),
                          adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                        ),
                      ),
                    );
                  }
                  );
            }
            else {
              return Center(
                child: Text('هیچ اطلاعاتی موجود نمی باشد!', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 18.0),),
              );
            }
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}
