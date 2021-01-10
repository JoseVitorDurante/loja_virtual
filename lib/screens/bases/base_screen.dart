import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer.dart';
import 'package:flutter_loja_ultimo/common/custom_drawer/custom_drawer_header.dart';
import 'package:flutter_loja_ultimo/models/page_manager.dart';
import 'package:flutter_loja_ultimo/screens/login/login_screen.dart';
import 'package:flutter_loja_ultimo/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        // physics:  const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text("home"),
            ),
          ),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text("home2"),
            ),
          ),
        ],
      ),
    );
  }
}
