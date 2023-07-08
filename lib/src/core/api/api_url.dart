import 'package:cloud_firestore/cloud_firestore.dart';

class ApiUrl {
  const ApiUrl._();

  static const baseUrl = "https://....com/api/v1";

  // static const products = "/products";
  static final products = FirebaseFirestore.instance.collection("products");
  static final users = FirebaseFirestore.instance.collection("users");
}
