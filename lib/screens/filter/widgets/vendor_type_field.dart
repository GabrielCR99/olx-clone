import 'package:flutter/material.dart';
import 'package:xlo/models/filter_model.dart';

class VendorTypeField extends StatelessWidget {
  final FormFieldSetter<int> onSaved;
  final int initialValue;

  VendorTypeField({this.onSaved, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      builder: (FormFieldState state) {
        return Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (state.value & VENDOR_TYPE_PARTICULAR != 0) {
                  if (state.value & VENDOR_TYPE_PROFESSIONAL != 0)
                    state.didChange(state.value & ~VENDOR_TYPE_PARTICULAR);
                  else
                    state.didChange(VENDOR_TYPE_PROFESSIONAL);
                } else {
                  state.didChange(state.value | VENDOR_TYPE_PARTICULAR);
                }
              },
              child: Container(
                width: 120.0,
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: state.value & VENDOR_TYPE_PARTICULAR != 0
                            ? Colors.transparent
                            : Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: state.value & VENDOR_TYPE_PARTICULAR != 0
                        ? Colors.blue
                        : Colors.transparent),
                alignment: Alignment.center,
                child: Text(
                  'Particular',
                  style: TextStyle(
                      color: state.value & VENDOR_TYPE_PARTICULAR != 0
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
              onTap: () {
                if (state.value & VENDOR_TYPE_PROFESSIONAL != 0) {
                  if (state.value & VENDOR_TYPE_PARTICULAR != 0)
                    state.didChange(state.value & ~VENDOR_TYPE_PROFESSIONAL);
                  else
                    state.didChange(VENDOR_TYPE_PARTICULAR);
                } else {
                  state.didChange(state.value | VENDOR_TYPE_PROFESSIONAL);
                }
              },
              child: Container(
                width: 120.0,
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: state.value & VENDOR_TYPE_PROFESSIONAL != 0
                            ? Colors.transparent
                            : Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: state.value & VENDOR_TYPE_PROFESSIONAL != 0
                        ? Colors.blue
                        : Colors.transparent),
                alignment: Alignment.center,
                child: Text(
                  'Profissional',
                  style: TextStyle(
                      color: state.value & VENDOR_TYPE_PROFESSIONAL != 0
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ],
        );
      },
      initialValue: initialValue,
      onSaved: onSaved,
    );
  }
}
