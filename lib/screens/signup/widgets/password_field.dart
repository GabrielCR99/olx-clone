import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final bool isEnabled;

  PasswordField({this.onSaved, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    Widget _buildBar(int number, String pass) {
      final int level = _calcScore(pass);
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              color: number <= level ? _getColor(level) : Colors.transparent,
              border:
                  number > level ? Border.all(color: Colors.grey[600]) : null),
        ),
      );
    }

    return FormField<String>(
      onSaved: onSaved,
      initialValue: '',
      validator: (text) {
        if (text.isEmpty || _calcScore(text) < 2) return 'Senha inválida';
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: state.didChange,
              enabled: isEnabled,
            ),
            if (state.value.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 6.0),
                height: 8.0,
                child: Row(
                  children: <Widget>[
                    _buildBar(0, state.value),
                    _buildBar(1, state.value),
                    _buildBar(2, state.value),
                    _buildBar(3, state.value),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 10.0),
              child: state.value.isNotEmpty || state.hasError
                  ? Text(
                      state.value.isNotEmpty
                          ? _getText(_calcScore(state.value))
                          : state.errorText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: _getColor(_calcScore(state.value)),
                          fontSize: 14.0),
                    )
                  : Container(),
            )
          ],
        );
      },
    );
  }

  int _calcScore(String pass) {
    int score = 0;
    if (pass.length > 8) score++;
    if (pass.contains(RegExp(r'[0-9]'))) score++;
    if (pass.contains(RegExp(r'[A-Z]'))) score++;
    return score;
  }

  Color _getColor(int level) {
    switch (level) {
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.orange;
        break;
      case 2:
        return Colors.greenAccent;
        break;
      case 3:
        return Colors.green;
        break;
      default:
        return Colors.red;
        break;
    }
  }

  String _getText(int level) {
    switch (level) {
      case 0:
        return 'Senha muito fraca';
        break;
      case 1:
        return 'Senha fraca';
        break;
      case 2:
        return 'Senha razoavel';
        break;
      case 3:
        return 'Senha forte';
        break;
      default:
        return '';
        break;
    }
  }
}
