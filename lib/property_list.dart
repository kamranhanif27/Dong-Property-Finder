import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import './property_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import './search_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import './filter_screen.dart';

class PropertyList extends StatefulWidget {
  PropertyList({Key key}) : super(key: key);
  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  static const String testDevice = '';

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['wallpaper', 'walls', 'amoled', 'afghanistan', 'property', 'house', 'building', 'family', 'puzzle', 'games', 'movies', 'musics', 'google', 'board games', 'map', 'politics', 'ANY', 'area'],
    childDirected: true
  );



  BannerAd _bannerAd =  BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {print('banner event: $event');},
    size: AdSize.smartBanner,
    );

  InterstitialAd _interstitialAd = InterstitialAd(
        adUnitId: 'ca-app-pub-8827475189355024/2239804315',
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {print('interstitial event: $event');}
    );

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

  _readProvince() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'province';
    final value = prefs.getString(key) ?? 'هرات';
    return value;
  }

  _setProvince(String province) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'province';
    prefs.setString(key, province);
  }

  String province;
  Future<List<Property>> _getProperties() async {
    province = await _readProvince();
    var data = await http.get("http://axisjustice.com/dong/dong.php?province=\"$province\"");
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
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-8827475189355024~9977218752');
//    _bannerAd = createBannerAd() ..show();
//    _interstitialAd = createInterstitialAd() ..show();
  }

  @override
  void dispose() {
    super.dispose();
//    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 1.0,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          height: 45.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(
                      FontAwesomeIcons.slidersH,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'فیلتر',
                      style: TextStyle(color: Colors.red, fontSize: 22.0),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Filter()));
                },
              ),
              InkWell(
                onTap: () async{
                 final retData =  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                  province = await _readProvince();
                  _setProvince(retData);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'انتخاب ولایت',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                      child: InkWell(
                        onTap: () {
                          _interstitialAd..load()..show();
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
                                length: snapshot.data[index].length,
                                width: snapshot.data[index].width,
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
                                  height: 15.0,
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
                                            Container(
                                              height: 30,
                                              width: 60,
                                              color: snapshot.data[index].package == 2 ? Colors.lightBlue : snapshot.data[index].package == 3 ? Colors.amber : Colors.transparent,
                                              child: Center(
                                                child: snapshot.data[index].package == 1 ? Text('') : snapshot.data[index].package == 2 ? Text('ویژه', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),) : Text('طلایی',  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                                              ),
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
                    ); else return Column(
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: AdmobBanner(
                              adUnitId: getBannerAdUnitId(),
                              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                          child: InkWell(
                            onTap: () {
                              print(snapshot.data[index].length);
                              _interstitialAd..load()..show();
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
                                    length: snapshot.data[index].length,
                                    width: snapshot.data[index].width,
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
                                      height: 15.0,
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
                                                Container(
                                                  height: 30,
                                                  width: 60,
                                                  color: snapshot.data[index].package == 2 ? Colors.lightBlue : snapshot.data[index].package == 3 ? Colors.amber : Colors.transparent,
                                                  child: Center(
                                                    child: snapshot.data[index].package == 1 ? Text('') : snapshot.data[index].package == 2 ? Text('ویژه', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),) : Text('طلایی',  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
                                                  ),
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
                        ),
                      ],
                    );
                  });
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

class Property {
  final int id;
  final String userId;
  final String title;
  final String propertyType;
  final String adType;
  final int area;
  final int length;
  final int width;
  final int beds;
  final int builtYear;
  final int price;
  final String address;
  final String province;
  final String details;
  final String image;
  final String name;
  final int phoneNumber;
  final int package;

  Property(this.id, this.userId, this.title, this.propertyType, this.adType, this.area, this.length, this.width, this.beds,
      this.builtYear, this.price, this.address, this.province, this.details, this.image, this.name, this.phoneNumber, this.package);
}
