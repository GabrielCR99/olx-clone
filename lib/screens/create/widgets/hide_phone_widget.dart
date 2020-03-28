import 'package:flutter/material.dart';

class HidePhoneWidget extends FormField<bool> {
  HidePhoneWidget({FormFieldSetter<bool> onSaved, bool initialValue})
      : super(
            initialValue: initialValue,
            onSaved: onSaved,
            builder: (state) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      onChanged: (b) {
                        state.didChange(b);
                      },
                      value: state.value,
                    ),
                    Text('Ocultar o meu telefone'),
                  ],
                ),
              );
            });
}
