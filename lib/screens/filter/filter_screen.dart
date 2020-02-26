import 'package:flutter/material.dart';
import 'package:xlo/models/filter_model.dart';
import 'package:xlo/screens/filter/widgets/animated_button.dart';
import 'package:xlo/screens/filter/widgets/order_by_field.dart';
import 'package:xlo/screens/filter/widgets/price_range_field.dart';
import 'package:xlo/screens/filter/widgets/section_title.dart';
import 'package:xlo/screens/filter/widgets/vendor_type_field.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  FilterModel _filter = FilterModel(
      maxPrice: 100,
      minPrice: 10,
      vendorType: VENDOR_TYPE_PARTICULAR,
      orderBy: OrderBy.PRICE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text('Filtrar Busca'),
      ),
      body: Stack(
        children: <Widget>[
          Form(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                const SectionTitle(title: 'Ordernar por'),
                OrderByField(
                  initialValue: _filter.orderBy,
                  onSaved: (v) {
                    _filter.orderBy = v;
                  },
                ),
                const SectionTitle(title: 'Preço R\$'),
                PriceRangeField(
                  filterModel: _filter,
                ),
                const SectionTitle(title: 'Tipo de anunciante'),
                VendorTypeField(
                  initialValue: _filter.vendorType,
                  onSaved: (v) {
                    _filter.vendorType = v;
                  },
                ),
              ],
            ),
            key: _formKey,
          ),
          AnimatedButton(
            scrollController: _scrollController,
            onTap: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (_filter.maxPrice != null && _filter.minPrice != null) {
                  if (_filter.minPrice > _filter.maxPrice) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text('Faixa de preço inválida'),
                      backgroundColor: Colors.pink,
                    ));
                    return;
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
