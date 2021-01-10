import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_loja_ultimo/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapshot =
        await firestore.collection("products").getDocuments();

    allProducts =
        snapshot.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }
}
