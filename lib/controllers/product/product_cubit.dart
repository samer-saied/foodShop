import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<ProductModel> products = [];
  List<ProductModel> topProducts = [];

  getProducts() async {
    if (products.isEmpty) {
      try {
        emit(ProductloadingState());

        await FirebaseFirestore.instance
            .collection('products')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            ProductModel product = ProductModel(
              productId: doc.id,
              currentPrice: doc["currentPrice"],
              prePrice: doc["prePrice"],
              status: doc["status"],
              categoryId: doc["categoryId"],
              description: doc["description"],
              imageUrl: doc["imageUrl"],
              title: doc["title"],
              available: doc['available'],
            );
            products.add(product);
          }
        });
        emit(ProductloadedState(products));
      } catch (error) {
        print(error.toString());
        emit(ProductErrorState(error.toString()));
      }
    }
  }

  getTopProducts() {
    if (products.isEmpty) {
      getProducts();
    }
    for (ProductModel product in products) {
      if (product.status == 'top') {
        topProducts.add(product);
      }
    }
  }
}
