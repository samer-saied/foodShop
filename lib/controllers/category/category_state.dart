part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryChangeSelectedState extends CategoryState {}

class CategoryLoadedSuccessState extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoadedSuccessState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}
