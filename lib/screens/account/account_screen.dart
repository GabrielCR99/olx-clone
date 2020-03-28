import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/edit_account/edit_account.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Minha Conta'),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Editar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditAccountScreen()));
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Gabriel Roveri',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(
              'Meus Anúncios',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            title: Text(
              'Favoritos',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ],
      ),
    );
  }
}
