import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/models/cart_product.dart';

class OrderProductTile extends StatelessWidget {
  final CartProduct cartProduct;

  const OrderProductTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed("/product", arguments: cartProduct.product),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(cartProduct.product.images.first),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartProduct.product.name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text(
                    "Tamanho: ${cartProduct.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cartProduct.fixedPrice?.toStringAsFixed(2) ?? cartProduct.unitPrice?.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Text(
              "${cartProduct.quantity}",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
