import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceSheet({Key key, this.onImageSelected});
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: Text('Câmera'),
              onPressed: () async{
                final File image = await ImagePicker.pickImage(source: ImageSource.camera);
                onImageSelected(image);
              },
            ),
            FlatButton(
              child: Text('Galeria'),
              onPressed: () async{
                final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                onImageSelected(image);
              },
            ),
          ],
        );
      },
      onClosing: () {},
    );
  }
}
