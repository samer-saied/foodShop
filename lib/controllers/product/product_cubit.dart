import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<ProductModel> products = [];
  List<ProductModel> topProducts = [];
  List<ProductModel> newProducts = [];

  getProducts() async {
    if (products.isEmpty) {
      try {
        emit(ProductloadingState());

        await FirebaseFirestore.instance
            .collection('products')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            ProductModel product = ProductModel.fronJson(
                doc.data() as Map<String, dynamic>, doc.id);
            products.add(product);
          }
        });
        // getNewProducts();
        emit(ProductloadedState(products));
      } catch (error) {
        print(error.toString());
        emit(ProductErrorState(error.toString()));
      }
    }
  }

  getTopProducts() {
    if (products.isNotEmpty) {
      topProducts = [];
      for (ProductModel product in products) {
        if (product.status == 'top') {
          topProducts.add(product);
        }
      }
    }
  }

  getNewProducts() async {
    if (products.isEmpty) {
      await getProducts();
      print("Get allllll Products");
    }
    newProducts.clear();
    print("rest new Products");

    for (ProductModel product in products) {
      if (product.status == 'new') {
        newProducts.add(product);
      }
    }
    print("finish");
  }
}
