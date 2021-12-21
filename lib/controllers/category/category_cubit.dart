import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());

  List<CategoryModel> categories = [];
  String selectedItem = '';
  int selectedItemIndex = 0;

  getCategories() async {
    if (categories.isEmpty) {
      try {
        emit(CategoryLoadingState());

        await FirebaseFirestore.instance
            .collection('categories')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            CategoryModel category = CategoryModel(
              categoryId: doc.id,
              description: doc["description"],
              imageUrl: doc["imageUrl"],
              title: doc["title"],
            );
            categories.add(category);
          }
        });
        if (categories.isNotEmpty) {
          selectedItem = categories[0].categoryId;
        }
        emit(CategoryLoadedSuccessState());
      } catch (error) {
        print(error.toString());
        emit(CategoryErrorState(error.toString()));
      }
    }
  }

  changeSelectedItem(
      {required int itemId, required BuildContext context}) async {
    emit(CategorychangeLoadingState());

    selectedItemIndex = itemId;
    selectedItem = categories[itemId].categoryId;
    print(selectedItem);
    context.read<ProductCubit>().getSelectedProduct(categoryId: selectedItem);

    emit(CategorychangeLoadedSuccessState());
  }
}
