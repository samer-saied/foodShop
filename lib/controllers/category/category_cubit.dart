import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:onlinefooddeliverysystem/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());

  List<CategoryModel> categories = [];
  int selectedItem = 0;

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
        emit(CategoryLoadedSuccessState(categories));
      } catch (error) {
        print(error.toString());
        emit(CategoryErrorState(error.toString()));
      }
    }
  }

  changeSelectedItem({required int itemId}) {
    // emit(CategoryLoadingState());
    selectedItem = itemId;
    emit(CategoryChangeSelectedState());
  }
}
