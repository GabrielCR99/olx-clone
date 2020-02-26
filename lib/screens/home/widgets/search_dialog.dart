import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  final String currentSearch;

  SearchDialog({this.currentSearch});

  @override
  _SearchDialogState createState() => _SearchDialogState(currentSearch);
}

class _SearchDialogState extends State<SearchDialog> {
  _SearchDialogState(String currentSearch)
      : _controller = TextEditingController(text: currentSearch);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 1,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.grey[700],
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
