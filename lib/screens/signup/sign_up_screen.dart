import 'package:flutter/material.dart';
import 'package:xlo/blocs/sign_up_bloc.dart';
import 'package:xlo/screens/signup/widgets/field_title.dart';
import 'package:xlo/screens/signup/widgets/password_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cadastrar'),
      ),
      body: Form(
        child: StreamBuilder<SignUpBlocState>(
            stream: _signUpBloc.outState,
            builder: (context, snapshot) {
              return ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                children: <Widget>[
                  const FieldTitle(
                    title: 'Apelido',
                    subtitle: 'Como aparecerá em seus anúncios',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Exemplo: João S.'),
                    validator: (text) {
                      if (text.length < 6)
                        return 'Apelido muito curto!';
                      else
                        return null;
                    },
                    onSaved: _signUpBloc.setName,
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const FieldTitle(
                    title: 'E-mail',
                    subtitle: 'Enviaremos um E-mail de confirmação!',
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    validator: (text) {
                      if (text.length < 6 || !text.contains('@'))
                        return 'E-mail inválido!';
                      else
                        return null;
                    },
                    onSaved: _signUpBloc.setEmail,
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  const FieldTitle(
                    title: 'Senha',
                    subtitle: 'Use números, letras e caracteres especiais',
                  ),
                  PasswordField(
                    onSaved: _signUpBloc.setPassword,
                    isEnabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24.0),
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.pink,
                      onPressed: snapshot.data.state != SignUpState.LOADING
                          ? _signUp
                          : null,
                      child: snapshot.data.state == SignUpState.LOADING
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Cadastre-se',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      disabledColor: Colors.pink.withAlpha(150),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Já tem uma conta?',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        GestureDetector(
                          child: Text(
                            ' Entrar',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                color: Colors.blue),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
        key: _formKey,
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _signUpBloc.signUp();
    }
  }
}
