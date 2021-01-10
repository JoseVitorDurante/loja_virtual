import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/helps/validators.dart';
import 'package:flutter_loja_ultimo/models/user.dart';
import 'package:flutter_loja_ultimo/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(builder: (_, UserManager, __) {
                return ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Nome completo"),
                      enabled: !UserManager.loading,
                      validator: (name) {
                        if (name.isEmpty) {
                          return "Campo obrigatorio";
                        } else if (name.trim().split(" ").length <= 1) {
                          return "Preencha seu nome completo";
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !UserManager.loading,
                      validator: (email) {
                        if (email.isEmpty) {
                          return "Campo obrigatorio";
                        } else if (!emailValid(email)) {
                          return "E-mail invalido";
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Senha"),
                      enabled: !UserManager.loading,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return "Senha obrigatoria";
                        } else if (pass.length < 6) {
                          return "Senha muito curta";
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Repita a senha"),
                      enabled: !UserManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return "Senha obrigatoria";
                        } else if (pass.length < 6) {
                          return "Senha muito curta";
                        }
                        return null;
                      },
                      onSaved: (confirmPass) =>
                          user.confirmPassword = confirmPass,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: UserManager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  if (user.password != user.confirmPassword) {
                                    scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          const Text('Senhas não coincidem!'),
                                      backgroundColor: Colors.red,
                                    ));
                                    return;
                                  }
                                  UserManager.signUp(
                                      user: user,
                                      onSuccess: () {
                                        Navigator.of(context).pop();
                                      },
                                      onFail: (e) {
                                        scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Falha ao cadastrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      });
                                }
                              },
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        child: UserManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Criar conta",
                                style: TextStyle(fontSize: 18),
                              ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
