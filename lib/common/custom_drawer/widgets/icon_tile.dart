import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isHighlighted;
  final VoidCallback onTap;

  const IconTile(
      {Key key, this.label, this.iconData, this.isHighlighted, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: .8,
          color: isHighlighted ? Colors.blue : Colors.black,
        ),
      ),
      leading: Icon(
        iconData,
        color: isHighlighted ? Colors.blue : Colors.black,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
    );
  }
}
