import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_loja_ultimo/models/address.dart';
import 'dart:io';

class User {

  User({this.email, this.password, this.name, this.id});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document["cpf"] as String;
    if(document.data.containsKey("address")){
      address = Address.fromMap(document.data["address"] as Map<String, dynamic>);
    }
  }

  String id;

  String name;

  String email;

  String password;

  String cpf;

  String confirmPassword;

  Address address;

  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference =>
      firestoreRef.collection('cart');

  CollectionReference get tokenReference =>
      firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
      if(cpf != null)
        "cpf": cpf,
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }

  void setCpf(String cpf){
    this.cpf = cpf;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    tokenReference.document(token).setData({
      "token": token,
      "updateAt": FieldValue.serverTimestamp(),
      "platform": Platform.operatingSystem,
    });
  }
}