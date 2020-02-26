import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';

class FacebookButton extends StatelessWidget {
  final LoginBloc _loginBloc;

  FacebookButton(this._loginBloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: 50.0,
      child: StreamBuilder<LoginBlocState>(
        stream: _loginBloc.outState,
        initialData: LoginBlocState(LoginState.IDLE),
        builder: (context, snapshot) {
          return RaisedButton(
            color: Color.fromRGBO(58, 89, 152, 1),
            disabledColor: Color.fromRGBO(58, 89, 152, .7),
            onPressed: snapshot.data.state == LoginState.LOADING_FACEBOOK
                ? null
                : () async {
                    final bool success = await _loginBloc.loginWithFacebook();
                    if (success) Navigator.of(context).pop();
                  },
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: snapshot.data.state == LoginState.LOADING_FACEBOOK
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Entrar com Facebook',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
          );
        },
      ),
    );
  }
}
