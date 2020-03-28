import 'package:flutter/material.dart';

import 'image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  final FormFieldSetter<List> onSaved;
  final List initialValue;

  ImagesField({Key key, this.onSaved, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      onSaved: onSaved,
      validator: (images) {
        if (images.isEmpty) return 'Campo Obrigatório!';
        return null;
      },
      initialValue: initialValue,
      builder: (state) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 140.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.value.length)
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ImageSourceSheet(
                                  onImageSelected: (image) {
                                    if (image != null)
                                      state.didChange(state.value..add(image));
                                    Navigator.of(context).pop();
                                  },
                                ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 16.0, bottom: 16.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 52,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera_alt,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              Text(
                                '+ Inserir',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.file(state.value[index]),
                                    FlatButton(
                                      child: const Text('Excluir'),
                                      onPressed: () {
                                        state.didChange(
                                            state.value..removeAt(index));
                                        Navigator.of(context).pop();
                                      },
                                      textColor: Colors.red,
                                    )
                                  ],
                                ),
                              ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: CircleAvatar(
                        radius: 52.0,
                        backgroundImage: FileImage(state.value[index]),
                      ),
                    ),
                  );
                },
                itemCount: state.value.length + 1,
              ),
            ),
            if (state.hasError)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              )
          ],
        );
      },
    );
  }
}
