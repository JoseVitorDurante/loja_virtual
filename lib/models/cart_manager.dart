import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_loja_ultimo/models/address.dart';
import 'package:flutter_loja_ultimo/models/product.dart';
import 'package:flutter_loja_ultimo/models/user.dart';
import 'package:flutter_loja_ultimo/models/user_manager.dart';
import 'package:flutter_loja_ultimo/services/cepaberto_service.dart';
import 'package:geolocator/geolocator.dart';

import 'cart_product.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  User user;

  Address address;

  num productsPrice = 0.0;

  num deliveryPrice;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  final Firestore firestore = Firestore.instance;

  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();

    items = cartSnap.documents
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;

    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];

      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartReference
          .document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAddressValid => address != null && deliveryPrice != null;

  //ADDRESS

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if (cepAbertoAddress != null) {
        address = Address(
          state: cepAbertoAddress.estado.sigla,
          city: cepAbertoAddress.cidade.nome,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          street: cepAbertoAddress.logradouro,
          lat: cepAbertoAddress.latitude,
          long: cepAbertoAddress.longitude,
        );
      }
      loading = false;
    } catch (e) {
      debugPrint(e.toString());
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  Future<void> setAddress(Address address)async {
    loading = true;
    this.address = address;

    if(await calculateDelivery(address.long, address.lat)){
      loading = false;
    }else{
      loading = false;
      return Future.error("Endereço fora do raio de entrega :(");
    }
  }

  void removeAddress() {
    deliveryPrice = null;
    address = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery(double long, double lat) async {
    final DocumentSnapshot doc = await firestore.document("aux/delivery").get();

    final latStrore = doc.data["lat"] as double;
    final longStore = doc.data["long"] as double;


    final maxKm = doc.data["maxKm"] as num;
    final base = doc.data["base"] as num;
    final km = doc.data["km"] as num;

    double dis = await Geolocator().distanceBetween(latStrore, longStore, lat, long);

    //transforma de metro em km
    dis /= 1000;


    if(dis > maxKm){
      return false;
    }else{
      deliveryPrice = base + dis * km;
      return true;
    }



  }
}
