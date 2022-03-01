import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  ProductService();

  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getProducts(name) {
    return productCollection
        .where("name", arrayContains: name)
        .get()
        .asStream();
  }

  Stream<QuerySnapshot> get sneakers_products => productCollection
      .where("category", isEqualTo: "sneakers")
      .get()
      .asStream();

  Stream<QuerySnapshot> get watches_products => productCollection
      .where("category", isEqualTo: "watches")
      .get()
      .asStream();

  Stream<QuerySnapshot> get jacket_products => productCollection
      .where("category", isEqualTo: "jackets")
      .get()
      .asStream();
}
