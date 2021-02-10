import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/orders_manager.dart';
import 'package:flutter_loja_ultimo/models/stores_manager.dart';
import 'package:flutter_loja_ultimo/screens/address/address_screen.dart';
import 'package:flutter_loja_ultimo/screens/bases/base_screen.dart';
import 'package:flutter_loja_ultimo/screens/cart/cart_screen.dart';
import 'package:flutter_loja_ultimo/screens/checkout/checkout_screen.dart';
import 'package:flutter_loja_ultimo/screens/confirmation/confirmation_screen.dart';
import 'package:flutter_loja_ultimo/screens/edit_product/edit_product_screen.dart';
import 'package:flutter_loja_ultimo/screens/login/login_screen.dart';
import 'package:flutter_loja_ultimo/screens/product/product_screen.dart';
import 'package:flutter_loja_ultimo/screens/select_product/select_product_screen.dart';
import 'package:flutter_loja_ultimo/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/admin_orders_manager.dart';
import 'models/admin_users_manager.dart';
import 'models/cart_manager.dart';
import 'models/home_manager.dart';
import 'models/order.dart';
import 'models/product.dart';
import 'models/product_manager.dart';
import 'models/user_manager.dart';

Future<void> main() async {
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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) =>
              adminOrdersManager..updateAdmin(userManager.adminEnabled),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager..updateUser(userManager.user),
        )
      ],
      child: MaterialApp(
        title: 'Loja do Daniel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(), settings: settings);
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) =>
                      ConfirmationScreen(settings.arguments as Order));
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);
          }
        },
      ),
    );
  }
}
