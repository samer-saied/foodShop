part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedSuccessState extends CategoryState {}

class CategorychangeLoadingState extends CategoryState {}

class CategorychangeLoadedSuccessState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String error;

  CategoryErrorState(this.error);
}
