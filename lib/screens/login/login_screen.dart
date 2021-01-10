import 'package:flutter_loja_ultimo/models/user.dart';
import 'package:flutter_loja_ultimo/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/helps/validators.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/signup");
              },
              textColor: Colors.white,
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        enabled: !userManager.loading,
                        controller: emailController,
                        decoration: InputDecoration(hintText: "E-mail"),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) return "E-mail invalido";
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        controller: passController,
                        decoration: InputDecoration(hintText: "Senha"),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty || pass.length < 6)
                            return "Senha invalida";
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text("Esqueci minha senha"),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : RaisedButton(
                                disabledColor: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(100),
                                onPressed: userManager.loading
                                    ? null
                                    : () {
                                        if (formKey.currentState.validate()) {
                                          userManager.singIn(
                                            user: User(
                                              email: emailController.text,
                                              password: passController.text,
                                            ),
                                            onFail: (e) {
                                              scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text("Falha ao entrar: $e"),
                                                backgroundColor: Colors.red,
                                              ));
                                            },
                                            onSuccess: (e) {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }
                                      },
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(fontSize: 18),
                                ),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                              ),
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
