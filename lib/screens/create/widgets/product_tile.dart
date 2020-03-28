import 'package:flutter/material.dart';
import 'package:xlo/helpers/format_field.dart';
import 'package:xlo/models/ad.dart';
import 'package:xlo/screens/product/product_screen.dart';

class ProductTile extends StatelessWidget {
  final Ad ad;

  ProductTile(this.ad);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductScreen(ad)));
      },
      child: Container(
        height: 135.0,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Card(
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 135.0,
                width: 127.0,
                child: Image.file(
                  ad.images[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ad.title,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'R\$${numToString(ad.price)}',
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${ad.address.district}, ${ad.address.city}',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
