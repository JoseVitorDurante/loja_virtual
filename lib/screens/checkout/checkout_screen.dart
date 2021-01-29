import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/common/price_card.dart';
import 'package:flutter_loja_ultimo/models/cart_manager.dart';
import 'package:flutter_loja_ultimo/models/checkou_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
      checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text("Pagamento"),
            centerTitle: true,
          ),
          body: Consumer<CheckoutManager>(builder: (_, checkoutManager, __) {
            if (checkoutManager.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      "Processando seu pagamento", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceCard(
                    buttonText: "Finalizar pedido",
                    onPressed: () {
                      checkoutManager.checkout(onStockFail: (e) {
                        Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/cart');
                      },onSuccess: (order){
                        Navigator.of(context).popUntil((route) => route.settings.name == "/base");
                        Navigator.of(context).pushNamed("/confirmation", arguments: order);
                      });
                    }),
              ],
            );
          })),
    );
  }
}
