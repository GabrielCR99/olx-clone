import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/helpers/format_field.dart';
import 'package:xlo/models/filter_model.dart';

class PriceRangeField extends StatelessWidget {
  final FilterModel filterModel;

  const PriceRangeField({this.filterModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: 'Min'),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false)
            ],
            initialValue: filterModel.minPrice?.toString(),
            onSaved: (s) {
              if (s.isEmpty)
                filterModel.minPrice = null;
              else
                filterModel.minPrice = int.parse(getSanitizedText(s));
            },
            validator: (s) {
              if (s.isNotEmpty && int.tryParse(getSanitizedText(s)) == null)
                return 'Utilize valores válidos';
              return null;
            },
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: 'Min'),
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              RealInputFormatter(centavos: false)
            ],
            initialValue: filterModel.maxPrice?.toString(),
            onSaved: (s) {
              if (s.isEmpty)
                filterModel.maxPrice = null;
              else
                filterModel.maxPrice = int.parse(getSanitizedText(s));
            },
            validator: (s) {
              if (s.isNotEmpty && int.tryParse(getSanitizedText(s)) == null)
                return 'Utilize valores válidos';
              return null;
            },
          ),
        ),
      ],
    );
  }
}
