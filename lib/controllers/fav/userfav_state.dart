part of 'userfav_cubit.dart';

@immutable
abstract class UserfavState {}

class UserfavInitial extends UserfavState {}

class FavloadingState extends UserfavState {}

class FavloadedState extends UserfavState {}
