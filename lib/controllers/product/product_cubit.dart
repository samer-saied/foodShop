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
  List<ProductModel> selectedProduct = [];
  List<ProductModel> selectedProductByCat = [];

  int selectedSize = 0;

  getProducts() async {
    if (products.isEmpty) {
      try {
        emit(ProductloadingState());

        await FirebaseFirestore.instance
            .collection('products')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            ProductModel product = ProductModel.fromJson(
                doc.data() as Map<String, dynamic>, doc.id);
            products.add(product);
          }
        });
        await getTopProducts();
        await getNewProducts();
        emit(ProductloadedState(products));
      } catch (error) {
        print(error.toString());
        emit(ProductErrorState(error.toString()));
      }
    }
  }

  getProductsForce() async {
    products.clear();
    try {
      emit(ProductloadingState());

      await FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          ProductModel product =
              ProductModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
          products.add(product);
        }
      });
      await getTopProducts();
      await getNewProducts();
      emit(ProductloadedState(products));
    } catch (error) {
      print(error.toString());
      emit(ProductErrorState(error.toString()));
    }
  }

  getTopProducts() async {
    if (products.isEmpty) {
      print("emptyyyyyyy");
      return;
    }
    topProducts.clear();
    for (ProductModel product in products) {
      if (product.status == 'top') {
        topProducts.add(product);
      }
    }
  }

  getNewProducts() async {
    if (products.isEmpty) {
      return;
    }
    newProducts.clear();
    for (ProductModel product in products) {
      if (product.status == 'new') {
        newProducts.add(product);
      }
    }
  }

  getSelectedProduct({required String categoryId}) async {
    selectedProduct.clear();
    products.forEach((product) {
      if (product.categoryId == categoryId) {
        selectedProduct.add(product);
        print(product.title + "-----------------------");
      }
    });
  }

  getSelectedProductByCategory({required String categoryId}) async {
    selectedProductByCat.clear();
    products.forEach((product) {
      if (product.categoryId == categoryId) {
        selectedProductByCat.add(product);
      }
    });
  }
}
