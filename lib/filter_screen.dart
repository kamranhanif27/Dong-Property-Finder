import 'package:Dong/filter_result.dart';
import 'package:flutter/material.dart';

import './reusable_items.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int radioValue = 0;
  String adType = 'فروشی';
  RangeValues _meterValues = RangeValues(1, 1000);

  int selectedBeds = 0;
  int selectedType = 0;

  bool showBeds = true;

  checkType(index) {
    if (index > 1) {
      setState(() {
        showBeds = false;
        selectedBeds = 0;
      });
    }else {
      setState(() {
        showBeds = true;
      });
    }
  }

  String propertyTypeValue() {

    String value;
    switch (selectedType) {
      case 0:
        value = 'آپارتمان';
        break;
      case 1:
        value = 'خانه';
        break;
      case 2:
        value = 'اداری';
        break;
      case 3:
        value = 'تجاری';
        break;
      case 4:
        value = 'زمین';
        break;
      case 5:
        value = 'ویلا';
        break;
      case 6:
        value = 'باغ';
        break;
    }
    return value;
  }

  int bedsValue() {

    int value;
    switch (selectedBeds) {
      case 0:
        value = 1;
        break;
      case 1:
        value = 2;
        break;
      case 2:
        value = 3;
        break;
      case 3:
        value = 4;
        break;
      case 4:
        value = 5;
        break;
      case 5:
        value = 6;
        break;
      case 6:
        value = 7;
        break;
      case 7:
        value = 8;
        break;
      case 8:
        value = 9;
        break;
      case 9:
        value = 10;
        break;
    }
    return value;
  }

  List<Color> containerColor = [
    Colors.grey.shade300,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  changeColor(index) {
    setState(() {
      containerColor = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ];
      containerColor[index] = Colors.grey.shade300;
      selectedBeds = index;
    });
  }

  List<Color> typeContainerColor = [
    Colors.grey.shade300,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  changeTypeColor(index) {
    setState(() {
      typeContainerColor = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ];
      typeContainerColor[index] = Colors.grey.shade300;
      selectedType = index;
    });
    checkType(index);
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
    if(value == 0){
      setState(() {
        adType = 'فروشی';
      });
    }else if(value == 1){
      setState(() {
        adType = 'کرایی';
      });
    }else if(value == 2){
      setState(() {
        adType = 'گروی';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'فیلتر',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 70.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Text(
                      'نوع آگهی:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'خرید',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<int>(
                          activeColor: Colors.redAccent,
                          value: 0,
                          onChanged: handleRadioValueChanged,
                          groupValue: radioValue,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'کرایه',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<int>(
                          activeColor: Colors.redAccent,
                          value: 1,
                          onChanged: handleRadioValueChanged,
                          groupValue: radioValue,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'گروی',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio<int>(
                          activeColor: Colors.redAccent,
                          value: 2,
                          onChanged: handleRadioValueChanged,
                          groupValue: radioValue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          showBeds == true ? Container(
            height: 100.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'تعداد خواب:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              changeColor(0);
                            },
                            child: BedNum(
                              color: containerColor[0],
                              bedNumber: 1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(1);
                            },
                            child: BedNum(
                              color: containerColor[1],
                              bedNumber: 2,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(2);
                            },
                            child: BedNum(
                              color: containerColor[2],
                              bedNumber: 3,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(3);
                            },
                            child: BedNum(
                              color: containerColor[3],
                              bedNumber: 4,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(4);
                            },
                            child: BedNum(
                              color: containerColor[4],
                              bedNumber: 5,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(5);
                            },
                            child: BedNum(
                              color: containerColor[5],
                              bedNumber: 6,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(6);
                            },
                            child: BedNum(
                              color: containerColor[6],
                              bedNumber: 7,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(7);
                            },
                            child: BedNum(
                              color: containerColor[7],
                              bedNumber: 8,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(8);
                            },
                            child: BedNum(
                              color: containerColor[8],
                              bedNumber: 9,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeColor(9);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: containerColor[9],
                                border: Border(
                                  top: BorderSide(width: 1.0, color: Colors.grey),
                                  right:
                                      BorderSide(width: 1.0, color: Colors.grey),
                                  bottom:
                                      BorderSide(width: 1.0, color: Colors.grey),
                                  left:
                                      BorderSide(width: 1.0, color: Colors.grey),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 33.0),
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : Container(),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 100.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'نوع ملک:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              changeTypeColor(0);
                            },
                            child: PropertyType(
                              color: typeContainerColor[0],
                              propertyType: 'آپارتمان',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(1);
                            },
                            child: PropertyType(
                              color: typeContainerColor[1],
                              propertyType: 'خانه',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(2);
                            },
                            child: PropertyType(
                              color: typeContainerColor[2],
                              propertyType: 'اداری',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(3);
                            },
                            child: PropertyType(
                              color: typeContainerColor[3],
                              propertyType: 'تجاری',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(4);
                            },
                            child: PropertyType(
                              color: typeContainerColor[4],
                              propertyType: 'زمین',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(5);
                            },
                            child: PropertyType(
                              color: typeContainerColor[5],
                              propertyType: 'ویلا',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              changeTypeColor(6);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: typeContainerColor[6],
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                  right: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                  left: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 33.0),
                                child: Text(
                                  'باغ',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 120.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 15.0, top: 15.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'متراژ:',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RangeSlider(
                      max: 1000,
                      min: 1,
                      divisions: 100,
                      values: _meterValues,
                      onChanged: (RangeValues newValues) {
                        setState(() {
                          _meterValues = newValues;
                        });
                      },
                      labels: RangeLabels(
                          'متر' + _meterValues.start.toInt().toString(),
                          'متر' + _meterValues.end.toInt().toString()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 45.0,
        width: double.infinity,
        child: MaterialButton(
          padding: EdgeInsets.all(0.0),
          color: Colors.redAccent,
          onPressed: () {
            print(bedsValue());
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => FilterResult(
                propertyType: propertyTypeValue(),
                beds: bedsValue(),
                adType: adType,
                areaStart: _meterValues.start.toInt(),
                areaEnd: _meterValues.end.toInt(),
              )
            ));
          },
          child: Text(
            'جستجو',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
