import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/common/custom_drawer/widgets/icon_tile.dart';

class IconSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerBloc _drawerBloc = Provider.of<DrawerBloc>(context);

    void _setPage(int page) {
      Navigator.of(context).pop();
      _drawerBloc.setPage(page);
    }

    return StreamBuilder<int>(
        stream: _drawerBloc.outPage,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              IconTile(
                label: 'Anúncios',
                onTap: () {
                  _setPage(0);
                },
                iconData: Icons.list,
                isHighlighted: snapshot.data == 0,
              ),
              IconTile(
                label: 'Inserir anúncio',
                onTap: () {
                  _setPage(1);
                },
                iconData: Icons.edit,
                isHighlighted: snapshot.data == 1,
              ),
              IconTile(
                label: 'Chat',
                onTap: () {
                  _setPage(2);
                },
                iconData: Icons.chat,
                isHighlighted: snapshot.data == 2,
              ),
              IconTile(
                label: 'Favortios',
                onTap: () {
                  _setPage(3);
                },
                iconData: Icons.star,
                isHighlighted: snapshot.data == 3,
              ),
              IconTile(
                label: 'Minha Conta',
                onTap: () {
                  _setPage(4);
                },
                iconData: Icons.account_box,
                isHighlighted: snapshot.data == 4,
              ),
            ],
          );
        });
  }
}
