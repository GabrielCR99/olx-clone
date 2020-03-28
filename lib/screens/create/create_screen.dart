import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/create_bloc.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/blocs/home_bloc.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/models/ad.dart';
import 'package:xlo/screens/create/widgets/hide_phone_widget.dart';
import 'package:xlo/screens/create/widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Ad ad = Ad();
  CreateBloc createBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Inserir Anúncio'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: StreamBuilder<CreateState>(
            stream: createBloc.outState,
            builder: (context, snapshot) {
              if (snapshot.data == CreateState.LOADING)
                return Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                      strokeWidth: 5.0,
                    ),
                  ),
                );
              return ListView(
                children: <Widget>[
                  ImagesField(
                    onSaved: (images) {
                      ad.images = images;
                    },
                    initialValue: [],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Título * ',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                          fontSize: 18),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return 'Campo Obrigatório!';
                      return null;
                    },
                    onSaved: (t) {
                      ad.title = t;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Descrição * ',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                          fontSize: 18),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    validator: (text) {
                      if (text.trim().isEmpty) return 'Campo Obrigatório!';
                      if (text.trim().length < 10)
                        return 'Descrição muito curta!';
                      return null;
                    },
                    onSaved: (d) {
                      ad.description = d;
                    },
                  ),
                  CepField(
                    decoration: InputDecoration(
                      labelText: 'CEP * ',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                          fontSize: 18),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    onSaved: (a) {
                      ad.address = a;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Preço * ',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                          fontSize: 18),
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true),
                    ],
                    validator: (text) {
                      if (text.trim().isEmpty) return 'Campo Obrigatório!';
                      if (int.tryParse(getSanitizedText(text)) == null)
                        return 'Utilie valores válidos!';
                      return null;
                    },
                    onSaved: (p) {
                      ad.price = int.parse(getSanitizedText(p)) / 100;
                    },
                  ),
                  HidePhoneWidget(
                    initialValue: false,
                    onSaved: (h) {
                      ad.isPhoneHiding = h;
                    },
                  ),
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        'Enviar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      ),
                      color: Colors.pinkAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Provider.of<HomeBloc>(context).addAd(ad);
                          final bool success = await createBloc.saveAd(ad);

                          if (success) {
                            Provider.of<DrawerBloc>(context).setPage(0);
                          }
                        }
                      },
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createBloc = CreateBloc();
  }

  @override
  void dispose() {
    super.dispose();
    createBloc?.dispose();
  }

  String getSanitizedText(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }
}
