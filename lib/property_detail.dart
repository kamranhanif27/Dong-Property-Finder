import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PropertyDetail extends StatefulWidget {
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

  PropertyDetail(
      {
        this.id,
        this.userId,
        this.title,
        this.propertyType,
        this.adType,
        this.area,
        this.length,
        this.width,
        this.beds,
        this.builtYear,
        this.price,
        this.address,
        this.province,
        this.details,
        this.image,
        this.name,
        this.phoneNumber
      });

  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {

  List<String> images = [];
  List<Widget> imgs = [];


  @override
  void initState() {
    super.initState();
    setState(() {
      images = widget.image.split(',').toList();
      imgs = images.map((i) => ClipRect(
        clipper: null,
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          height: 200.0,
          placeholder: 'assets/image/image-placeholder.jpg',
          image: 'http://axisjustice.com/dong/images/${widget.userId}/$i',
        ),
      )).toList();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 300.0,
                    width: double.infinity,
                    child: Swiper(
                      itemCount: imgs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return imgs[index];
                      },
                      pagination: SwiperPagination(),
                      autoplay: true,
                      control: SwiperControl(size: 18.0,),
                      controller: SwiperController(),
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.black.withOpacity(0.1),
                    elevation: 0.0,
                    actions: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Text(
                widget.title,
                textDirection: TextDirection.rtl,
                style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 22.0, color: Colors.red),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.propertyType,
                    textDirection: TextDirection.rtl,
                    style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                  Text(
                    widget.adType,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 22.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.adType == 'کرایی' ? 'کرایه ماهوار:' : 'قیمت:',
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        widget.price.toString(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'افغانی',
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '${widget.area} متر مربع',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                    Text(
                      'طول ${widget.length}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                      ),
                    ),
                    Text(
                      'عرض ${widget.width}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                      ),
                    ),
                    widget.propertyType == 'خانه' ||  widget.propertyType == 'آپارتمان' ? Text(
                      '${widget.beds} خواب',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ) : Text(''),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                'ولایت: ${widget.province}',
                textDirection: TextDirection.rtl,
                style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                widget.address,
                textDirection: TextDirection.rtl,
                style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                'منتشر کننده',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'کد آگهی: ${widget.id}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'نام: ${widget.name}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                'توضیحات',
                textDirection: TextDirection.rtl,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Wrap(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Text(
                    widget.details,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 2.0, // has the effect of softening the shadow
                spreadRadius: 0.5, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  -0.5, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  shape: StadiumBorder(),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  color: Colors.lightGreen,
                  onPressed: () {
                    launch("sms://+93${widget.phoneNumber}");
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'پیام',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.message,
                        size: 18.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  shape: StadiumBorder(),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  color: Colors.deepOrange,
                  onPressed: () {
                    launch("tel://+93${widget.phoneNumber}");
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'تماس',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.phone,
                        size: 18.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

