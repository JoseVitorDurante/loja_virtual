import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/product_manager.dart';
import 'package:flutter_loja_ultimo/models/user_manager.dart';
import 'package:flutter_loja_ultimo/screens/base/base_screen.dart';
import 'package:flutter_loja_ultimo/screens/login/login_screen.dart';
import 'package:flutter_loja_ultimo/screens/product/product_screen.dart';
import 'package:flutter_loja_ultimo/screens/products/products_screen.dart';
import 'package:flutter_loja_ultimo/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Loja Do Vitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141),
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/base",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/signup":
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case "/product":
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
            case "/login":
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case "/base":
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
