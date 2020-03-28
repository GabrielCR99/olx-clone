import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {
  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  CepField({Key key, this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {
  InputDecoration get decoration => widget.decoration;

  FormFieldSetter<Address> get onSaved => widget.onSaved;

  CepBloc _cepBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
        initialData: CepBlocState(cepFieldState: CepFieldState.INITIALIZING),
        stream: _cepBloc.outCep,
        builder: (context, snapshot) {
          if (snapshot.data.cepFieldState == CepFieldState.INITIALIZING)
            return Container();
          return Column(
            children: <Widget>[
              TextFormField(
                validator: (c) {
                  switch (snapshot.data.cepFieldState) {
                    case CepFieldState.INITIALIZING:
                    case CepFieldState.INCOMPLETE:
                    case CepFieldState.INVALID:
                      return 'Campo obrigatório!';
                    case CepFieldState.VALID:
                  }
                  return null;
                },
                initialValue: snapshot.data.cep,
                onChanged: _cepBloc.onChanged,
                onSaved: (c) {
                  onSaved(snapshot.data.address);
                },
                decoration: decoration,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
              ),
              _buildInformation(snapshot.data),
            ],
          );
        });
  }

  Widget _buildInformation(CepBlocState blocState) {
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
      case CepFieldState.INVALID:
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          color: Colors.red.withAlpha(100),
          alignment: Alignment.center,
          child: Text(
            'CEP inválido!',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      case CepFieldState.VALID:
        final Address _address = blocState.address;
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8.0),
          color: Colors.pinkAccent,
          alignment: Alignment.center,
          child: Text(
            'Localização: ${_address.district} - ${_address.city} - ${_address.federativeUnity}',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _cepBloc = CepBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _cepBloc?.dispose();
  }
}
