import 'package:flutter/material.dart';
import 'package:xlo/models/ad.dart';

class LocationPanel extends StatelessWidget {
  final Ad ad;

  LocationPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
          child: Text(
            'Localização',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: const <Widget>[
                  Text('CEP'),
                  SizedBox(height: 12.0),
                  Text('Município'),
                  SizedBox(height: 12.0),
                  Text('Bairro'),
                  SizedBox(height: 12.0),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('${ad.address.postalCode}'),
                  SizedBox(height: 12.0),
                  Text('${ad.address.city}'),
                  SizedBox(height: 12.0),
                  Text('${ad.address.district}'),
                  SizedBox(height: 12.0),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ))
          ],
        )
      ],
    );
  }
}
