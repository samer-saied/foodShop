part of 'banner_cubit.dart';

@immutable
abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadedState extends BannerState {
  final List<BannerModel> banners;

  BannerLoadedState(this.banners);
}

class BannerLoadingState extends BannerState {}

class BannerErrorState extends BannerState {
  final String errorMsg;

  BannerErrorState(this.errorMsg);
}
