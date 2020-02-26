import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/screens/login/widgets/facebook_button.dart';
import 'package:xlo/screens/login/widgets/login_button.dart';
import 'package:xlo/screens/login/widgets/or_divider.dart';
import 'package:xlo/screens/signup/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible;
  LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FacebookButton(_loginBloc),
              OrDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 11.0),
                child: Text(
                  'Acessar com E-mail:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[900]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, bottom: 4.0),
                child: Text(
                  'E-mail',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700),
                ),
              ),
              StreamBuilder<FieldState>(
                initialData: FieldState(),
                stream: _loginBloc.outEmail,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        errorText: snapshot.data.error),
                    onChanged: _loginBloc.changeEmail,
                    enabled: snapshot.data.enable,
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 26.0, left: 3.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Senha',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<FieldState>(
                stream: _loginBloc.outPassword,
                initialData: FieldState(),
                builder: (context, snapshot) {
                  return TextField(
                    onChanged: _loginBloc.changePassword,
                    enabled: snapshot.data.enable,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isVisible,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      errorText: snapshot.data.error,
                      suffixIcon: IconButton(
                        icon: Icon(isVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              LoginButton(_loginBloc),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Não tem uma conta?',
                        style: TextStyle(fontSize: 16.0)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        ' Cadastre-se!',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(elevation: 0, title: const Text('Entrar')),
    );
  }

  @override
  void initState() {
    super.initState();
    isVisible = true;
  }
}
