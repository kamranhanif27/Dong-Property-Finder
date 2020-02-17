import 'dart:convert' show utf8;
import 'dart:convert' as prefix1;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as prefix0;
import './login.dart';

class AddAdScreen extends StatefulWidget {
  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  bool isLoggedIn = false;
  FirebaseUser _user;

  void _uploadFile(filePath, fileName) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid.toString();
    print('file base name: $fileName');
    print(uid);
    try {
      FormData formData = FormData.from(
          {"file": UploadFileInfo(filePath, fileName), "folder": uid});

      Response response = await Dio()
          .post("http://axisjustice.com/dong/uploadImage.php", data: formData);
      print("response: $response");
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  bool progressBar = true;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      // etc
      setState(() {
        isLoggedIn = true;
        _user = user;
      });
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        progressBar = false;
      });
    });
  }

  int radioValue = 0;
  String adType = 'فروشی';
  String _title;
  bool _titleValidate = false;
  int _meter;
  bool _meterValidate = false;
  int _priceAmount;
  bool _priceValidate = false;
  String _details;
  bool _detailsValidate = false;
  String _address;
  bool _addressValidate = false;
  String _name;
  bool _nameValidate = false;
  int _number;
  bool _numberValidate = false;
  int _length;
  bool _lengthValidate = false;
  int _width;
  bool _widthValidate = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
    handlePriceChanged(value);
  }

  void handlePriceChanged(int value) {
    if (value == 0) {
      setState(() {
        adType = 'فروشی';
        _price = 'قیمت:';
      });
    }else if(value == 1){
      setState(() {
        adType = 'کرایی';
        _price = 'کرایه ماهانه:';
      });
    }else if(value == 2){
      setState(() {
        adType = 'گروی';
        _price = 'قیمت:';
      });
    }
  }

  var _price = 'قیمت:';

  var _propertyType = ['خانه', 'آپارتمان', 'اداری', 'تجاری', 'ویلا', 'زمین', 'باغ'];
  var _currentSelectedProperty = 'خانه';

  var _province = ['کابل', 'هرات', 'مزار شریف', 'کندهار'];
  var _currentSelectedProvince = 'هرات';

  var _propertyBeds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var _currentSelectedBeds = 1;

  File _image;
  String _imageName;
  bool _imageValidate = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      _imageValidate = true;
      _imageName = DateTime.now().millisecondsSinceEpoch.toString() +
          prefix0.basename(image.path);
    });
  }

  File _image2;
  String _image2Name;
  bool _image2Validate = false;

  Future getImage2() async {
    var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image2 = image2;
      _image2Validate = true;
      _image2Name = DateTime.now().millisecondsSinceEpoch.toString() +
          prefix0.basename(image2.path);
    });
  }

  File _image3;
  String _image3Name;
  bool _image3Validate = false;

  Future getImage3() async {
    var image3 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image3 = image3;
      _image3Validate = true;
      _image3Name = DateTime.now().millisecondsSinceEpoch.toString() +
          prefix0.basename(image3.path);
    });
  }

  void getTitle(String value) => setState(() {
        _title = value;
        if (_title.length < 10) {
          _titleValidate = false;
        } else {
          _titleValidate = true;
        }
      });

  void getMeter(String value) => setState(() {
        if (value.contains(',') || value.contains('.') || value.contains('+')) {
          _meterValidate = false;
        } else {
          _meter = int.parse(value);
          _meterValidate = true;
        }
      });

  void getPrice(String value) => setState(() {
        if (value.contains(',') || value.contains('.') || value.contains('+')) {
          _priceValidate = false;
        } else {
          _priceAmount = int.parse(value);
          _priceValidate = true;
        }
      });

  void getDetails(String value) => setState(() {
        _details = value;
        if (_details.length < 20) {
          _detailsValidate = false;
        } else {
          _detailsValidate = true;
        }
      });

  void getAddress(String value) => setState(() {
        _address = value;
        if (_address.length < 10) {
          _addressValidate = false;
        } else {
          _addressValidate = true;
        }
      });

  void getName(String value) => setState(() {
        _name = value;
        if (_name.length < 5) {
          _nameValidate = false;
        } else {
          _nameValidate = true;
        }
      });

  void getNumber(String value) => setState(() {
        if (value.contains(',') || value.contains('.') || value.contains('+')) {
          _numberValidate = false;
        } else {
          _number = int.parse(value);
          _numberValidate = true;
        }
      });

  void getLength(String value) => setState(() {
    if (value.contains(',') || value.contains('.') || value.contains('+')) {
      _lengthValidate = false;
    } else {
      _length = int.parse(value);
      _lengthValidate = true;
    }
  });

  void getWidth(String value) => setState(() {
    if (value.contains(',') || value.contains('.') || value.contains('+')) {
      _widthValidate = false;
    } else {
      _width = int.parse(value);
      _widthValidate = true;
    }
  });

  @override
  Widget build(BuildContext context) {
    return progressBar
        ? Center(
            child: CircularProgressIndicator(),
          )
        : isLoggedIn
            ? Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Center(
                        child: Text(
                          'ثبت آگهی',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Container(
                  padding: EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    color: Colors.black54,
                                    width: double.infinity,
                                    child: Text(
                                      'مشخصات ملک',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text('نوع آگهی:',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'فروشی',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Radio<int>(
                                      activeColor: Colors.redAccent,
                                      value: 0,
                                      onChanged: handleRadioValueChanged,
                                      groupValue: radioValue,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      'کرایی',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Radio<int>(
                                      activeColor: Colors.redAccent,
                                      value: 1,
                                      onChanged: handleRadioValueChanged,
                                      groupValue: radioValue,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      'گروی',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Radio<int>(
                                      activeColor: Colors.redAccent,
                                      value: 2,
                                      onChanged: handleRadioValueChanged,
                                      groupValue: radioValue,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Input(
                                  'عنوان آگهی',
                                  TextInputType.text,
                                  function: getTitle,
                                  errorMsg: _titleValidate
                                      ? null
                                      : 'عنوان باید از ۱۰ حرف کمتر نباشد',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'متراژ( متر مربع )',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                100 *
                                                40,
                                            height: 40.0,
                                            color: Colors.grey.shade200,
                                            child: TextField(
                                              onChanged: getMeter,
                                              keyboardType:
                                              TextInputType.number,
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                errorText: _meterValidate
                                                    ? null
                                                    : 'لطفا اعداد درست را وارد نمایید',
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 12.0),
                                                filled: true,
                                                fillColor: Colors.grey.shade100,
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                        Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                100 *
                                                1.0,
                                      ),
                                      Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'نوع ملک',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100 *
                                                40,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                canvasColor:
                                                    Colors.grey.shade200,
                                              ),
                                              child: DropdownButton<String>(
                                                underline: Container(),
                                                isExpanded: true,
                                                items: _propertyType.map((String
                                                    dropDownStringItem) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    child: Text(
                                                        dropDownStringItem),
                                                    value: dropDownStringItem,
                                                  );
                                                }).toList(),
                                                onChanged: (String newValue) {
                                                  newValue != 'خانه' || newValue != 'آپارتمان' ? _currentSelectedBeds = 1 : print('nothing');
                                                  setState(() {
                                                    _currentSelectedProperty =
                                                        newValue;
                                                  });
                                                },
                                                value: _currentSelectedProperty,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      _currentSelectedProperty == 'خانه' || _currentSelectedProperty == 'آپارتمان' ? Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'تعداد خواب',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width * 100 / 120,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                canvasColor:
                                                    Colors.grey.shade200,
                                              ),
                                              child: DropdownButton<int>(
                                                underline: Container(),
                                                isExpanded: true,
                                                items: _propertyBeds.map(
                                                    (int dropDownStringItem) {
                                                  return DropdownMenuItem<int>(
                                                    child: Text(
                                                        dropDownStringItem
                                                            .toString()),
                                                    value: dropDownStringItem,
                                                  );
                                                }).toList(),
                                                onChanged: (int newValue) {
                                                  setState(() {
                                                    _currentSelectedBeds =
                                                        newValue;
                                                  });
                                                },
                                                value: _currentSelectedBeds,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ) : Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            width: double.infinity,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'طول',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                100 *
                                                42,
                                            height: 40.0,
                                            color: Colors.grey.shade200,
                                            child: TextField(
                                              onChanged: getLength,
                                              keyboardType:
                                              TextInputType.number,
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                errorText: _lengthValidate
                                                    ? null
                                                    : 'لطفا اعداد درست را وارد نمایید',
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 12.0),
                                                filled: true,
                                                fillColor: Colors.grey.shade100,
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                        Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width /
                                            100 *
                                            1.0,
                                      ),
                                      Column(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'عرض',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                100 *
                                                42,
                                            height: 40.0,
                                            color: Colors.grey.shade200,
                                            child: TextField(
                                              onChanged: getWidth,
                                              keyboardType:
                                              TextInputType.number,
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                errorText: _widthValidate
                                                    ? null
                                                    : 'لطفا اعداد درست را وارد نمایید',
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 12.0),
                                                filled: true,
                                                fillColor: Colors.grey.shade100,
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                        Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Input(
                                  _price,
                                  TextInputType.number,
                                  function: getPrice,
                                  errorMsg: _priceValidate
                                      ? null
                                      : 'لطفا اعداد درست را وارد نمایید',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'توضیحات آگهی',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: TextField(
                                    onChanged: getDetails,
                                    maxLines: 8,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      errorText: _detailsValidate
                                          ? null
                                          : 'توضیحات باید از ۲۰ حرف کمتر نباشد',
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 12.0),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.0, color: Colors.grey)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'تصاویر',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  height: MediaQuery.of(context).size.height /
                                      100 *
                                      20,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      left: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      top: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            InkWell(
                                              child: _image == null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              25,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              20,
                                                      color: Colors.grey,
                                                      child: Center(
                                                        child: Icon(Icons.add),
                                                      ),
                                                    )
                                                  : Image.file(
                                                      _image,
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),
                                              onTap: () {
                                                getImage();
                                              },
                                            ),
                                            InkWell(
                                              child: _image2 == null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              25,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              20,
                                                      color: Colors.grey,
                                                      child: Center(
                                                        child: Icon(Icons.add),
                                                      ),
                                                    )
                                                  : Image.file(
                                                      _image2,
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),
                                              onTap: () {
                                                getImage2();
                                              },
                                            ),
                                            InkWell(
                                              child: _image3 == null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              25,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              100 *
                                                              20,
                                                      color: Colors.grey,
                                                      child: Center(
                                                        child: Icon(Icons.add),
                                                      ),
                                                    )
                                                  : Image.file(
                                                      _image3,
                                                      width: 100.0,
                                                      height: 100.0,
                                                    ),
                                              onTap: () {
                                                getImage3();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 5.0),
                                  child: Text(
                                    '* هر سه تصویر باید انتخاب شود.',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    color: Colors.black54,
                                    width: double.infinity,
                                    child: Text(
                                      'موقعیت ملک',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'ولایت',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  padding: const EdgeInsets.only(left: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.grey.shade200,
                                    ),
                                    child: DropdownButton<String>(
                                      underline: Container(),
                                      isExpanded: true,
                                      items: _province
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          child: Text(dropDownStringItem),
                                          value: dropDownStringItem,
                                        );
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _currentSelectedProvince = newValue;
                                        });
                                      },
                                      value: _currentSelectedProvince,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Input(
                                  'آدرس',
                                  TextInputType.text,
                                  function: getAddress,
                                  errorMsg: _addressValidate
                                      ? null
                                      : 'آدرس باید از ۱۰ حرف کمتر نباشد',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    color: Colors.black54,
                                    width: double.infinity,
                                    child: Text(
                                      'اطلاعات تماس',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Input(
                                  'نام و نام خانوادگی',
                                  TextInputType.text,
                                  function: getName,
                                  errorMsg: _nameValidate
                                      ? null
                                      : 'نام کامل خود را وارد نمایید',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'شماره مبایل',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: TextField(
                                    onChanged: getNumber,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      prefixText: '+۹۳',
                                      errorText: _numberValidate
                                          ? null
                                          : 'شماره درست را وارد نمایید',
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 12.0),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.0, color: Colors.grey)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Card(
                            child: Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    color: Colors.black54,
                                    width: double.infinity,
                                    child: Text(
                                      'نوع آگهی',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('آگهی ساده', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),),
                                    Radio(
                                      value: 0,
                                      groupValue: 0,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('آگهی ویژه', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.lightBlue),),
                                    Radio(
                                      value: 1,
                                      groupValue: 0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 35.0),
                                  child: Text('نمایش در صدر نتایج جستجو برای ۷ روز ( هزار افغانی )', style: TextStyle(color: Colors.black87),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text('آگهی طلایی', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.amber),),
                                    Radio(
                                      value: 2,
                                      groupValue: 0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 35.0),
                                  child: Text('نمایش در صدر نتایج جستجو برای ۱۴ روز ( دو هزار افغانی )', style: TextStyle(color: Colors.black87),),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text('* برای خرید آگهی ویژه و یا آگهی طلایی لطفا با ما به تماس شوید.', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.grey),),
                                ),
                                SizedBox(
                                  height: 15.0,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 40.0,
                          width: double.infinity,
                          child: MaterialButton(
                            padding: EdgeInsets.all(0.0),
                            color: Colors.redAccent,
                            onPressed: () async {
                              if (_titleValidate == true &&
                                  _meterValidate == true &&
                                  _priceValidate == true &&
                                  _detailsValidate == true &&
                                  _addressValidate == true &&
                                  _nameValidate == true &&
                                  _numberValidate == true &&
                                  _lengthValidate == true &&
                                  _widthValidate == true &&
                                  _imageValidate == true &&
                                  _image2Validate == true &&
                                  _image3Validate == true) {
                                _uploadFile(_image, _imageName);
                                _uploadFile(_image2, _image2Name);
                                _uploadFile(_image3, _image3Name);
                                final FirebaseUser user =
                                    await FirebaseAuth.instance.currentUser();
                                final uid = user.uid.toString();
                                // set up POST request arguments
                                String url =
                                    'http://axisjustice.com/dong/dong.php';
                                Map<String, String> headers = {
                                  "Content-type":
                                      "application/json; charset=utf-8",
                                  "accept": "application/json",
                                };
                                var json = {
                                  "user_id": "$uid",
                                  "title": "$_title",
                                  "propertyType": "$_currentSelectedProperty",
                                  "adType": "$adType",
                                  "area": _meter,
                                  "length": _length,
                                  "width": _width,
                                  "beds": _currentSelectedBeds,
                                  "price": _priceAmount,
                                  "address": "$_address",
                                  "province": "$_currentSelectedProvince",
                                  "details": "$_details",
                                  "name": "$_name",
                                  "image":
                                      "$_imageName,$_image2Name,$_image3Name",
                                  "phoneNumber": _number
                                };
                                var response = await http.post(
                                    Uri.encodeFull(url),
                                    headers: headers,
                                    body:
                                        utf8.encode(prefix1.json.encode(json)));
                                print(prefix1.json.encode(json));
                                if (response.statusCode == 200) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 80,
                                            child: Center(
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 76,
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('تایید'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/homepage',
                                                        (_) => false);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 80,
                                            child: Center(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 76,
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('تایید'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
//                                              Navigator.pushNamedAndRemoveUntil(context, '/homepage', (_) => false);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'اشکال!',
                                          textDirection: TextDirection.rtl,
                                        ),
                                        content: Container(
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'لطفا فرم را بصورت درست خانه پوری کنید',
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('تایید'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Text(
                              'ثبت آگهی',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Container(
                    width: MediaQuery.of(context).size.width / 100 * 45,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.red.shade400,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      },
                      child: Text(
                        'ورود / ثبت نام',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    )),
              );
  }
}

class Input extends StatelessWidget {
  final String title;
  final TextInputType inputType;
  final Function function;
  var errorMsg = null;

  Input(this.title, this.inputType, {this.function, this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: TextField(
            onChanged: function,
            keyboardType: inputType,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              errorText: errorMsg,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              filled: true,
              fillColor: Colors.grey.shade100,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
