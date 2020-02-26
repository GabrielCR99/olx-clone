import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const FieldTitle({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '$title   ',
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16.0,
                fontWeight: FontWeight.w800),
          ),
          Text(
            '$subtitle',
            style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
