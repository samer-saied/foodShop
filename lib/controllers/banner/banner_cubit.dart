import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onlinefooddeliverysystem/models/banner_model.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitialState());

  List<BannerModel> banners = [];

  getBanners() async {
    emit(BannerLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('banners')
          .orderBy('priority')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          BannerModel banner = BannerModel(
            bannerId: doc.id,
            description: doc["description"],
            imageUrl: doc["imageUrl"],
            referId: doc["referId"],
            title: doc["title"],
            priority: doc['priority'] ?? 0,
          );
          banners.add(banner);
        }
      });
      emit(BannerLoadedState(banners));
    } catch (error) {
      print(error.toString());
      emit(BannerErrorState(error.toString()));
    }
  }
}
