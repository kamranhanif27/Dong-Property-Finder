import 'package:Dong/property_detail.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FilterResult extends StatefulWidget {

  final String adType;
  final String propertyType;
  final int beds;
  final int areaStart;
  final int areaEnd;

  FilterResult({this.adType, this.propertyType, this.beds, this.areaEnd, this.areaStart});

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {


  _readProvince() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'province';
    final value = prefs.getString(key) ?? 'هرات';
    return value;
  }

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: <String>[],
      keywords: <String>['wallpaper', 'walls', 'amoled', 'afghanistan', 'property', 'house', 'building', 'family', 'puzzle', 'games', 'movies', 'musics', 'google', 'board games', 'map', 'politics', 'ANY', 'area'],
      childDirected: true
  );
  InterstitialAd _interstitialAd = InterstitialAd(
      adUnitId: 'ca-app-pub-8827475189355024/2239804315',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {print('interstitial event: $event');}
  );
  BannerAd _bannerAd =  BannerAd(
    adUnitId: 'ca-app-pub-8827475189355024/9698017157',
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {print('banner event: $event');},
    size: AdSize.smartBanner,
  );


  String province;
  Future<List<Property>> _getProperties() async {
    province = await _readProvince();
    var data = await http.get("http://axisjustice.com/dong/dong.php?province=\"$province\"&adType=\"${widget.adType}\"&beds=\"${widget.beds}\"&propertyType=\"${widget.propertyType}\"&areaStart=\"${widget.areaStart}\"&areaEnd=\"${widget.areaEnd}\"");
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
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-8827475189355024~9977218752');
    _bannerAd..load()..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
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
                'نتایج فیلتر',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
                  itemBuilder: (context, index) => Padding(
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
                  ));
            }
            else {
              return Center(
                child: Text('هیچ اطلاعاتی موجود نمی باشد!', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 18.0),),
              );
            }
          } else {
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
