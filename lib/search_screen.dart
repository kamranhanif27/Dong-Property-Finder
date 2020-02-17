import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  static const menuItems = <String>[
    'هرات',
    'کابل',
    'مزار شریف',
    'کندهار',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems.
      map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      )
  ).toList();

  String _provinceValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 15.0),
            child: Text(
              'کدام ولایت، شهر یا محله؟',
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 30.0),
              color: Colors.white,
              child: DropdownButton(
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                value: _provinceValue,
                onChanged: (String newValue) {
                  setState((){
                    _provinceValue = newValue;
                  });
                },
                items: _dropDownMenuItems,
                hint: Text('ولایت', textDirection: TextDirection.rtl,),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 45.0,
        width: double.infinity,
        child: MaterialButton(
          padding: EdgeInsets.all(0.0),
          color: Colors.redAccent,
          onPressed: () {
            Navigator.pop(context, _provinceValue);
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
