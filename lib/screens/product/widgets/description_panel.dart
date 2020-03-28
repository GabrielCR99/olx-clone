import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class DescriptionPanel extends StatefulWidget {
  final Ad ad;

  DescriptionPanel(this.ad);

  @override
  _DescriptionPanelState createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<DescriptionPanel> {
  Ad get ad => widget.ad;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'Descrição',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            ad.description,
            maxLines: isOpen ? 10 : 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        if (isOpen || ad.description.length < 100)
          const SizedBox(height: 18.0)
        else
          Align(
            alignment: Alignment.centerLeft,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  isOpen = true;
                });
              },
              child: Text(
                'Ver descrição completa',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.pinkAccent),
              ),
              padding: EdgeInsets.zero,
            ),
          )
      ],
    );
  }
}
