import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.account_circle, color: Theme
                .of(context)
                .primaryColor, size: 100,),
            Padding(padding: EdgeInsets.fromLTRB(16,16,16,4),
              child: Text(
                "Faça login para acessar", textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800, color: Theme
                    .of(context)
                    .primaryColor),),),
            RaisedButton(onPressed: () {
              Navigator.of(context).pushNamed("/login");
            }, child: Text("Login"), color: Theme
                .of(context)
                .primaryColor, textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}
