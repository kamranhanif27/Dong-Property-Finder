import 'package:flutter/material.dart';


class BedNum extends StatelessWidget {
  BedNum({@required this.color, @required this.bedNumber});
  final Color color;
  final int bedNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 33.0),
        child: Text(bedNumber.toString(), style: TextStyle(fontSize: 18.0, color: Colors.grey),),
      ),
    );
  }
}

class PropertyType extends StatelessWidget {
  PropertyType({@required this.color, @required this.propertyType});
  final Color color;
  final String propertyType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey),
          right: BorderSide(width: 1.0, color: Colors.grey),
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 33.0),
        child: Text(propertyType, style: TextStyle(fontSize: 18.0, color: Colors.grey),),
      ),
    );
  }
}
