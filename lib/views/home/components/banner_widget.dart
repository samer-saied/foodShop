import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/banner/banner_cubit.dart';
import 'package:onlinefooddeliverysystem/models/banner_model.dart';
import 'package:shimmer/shimmer.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ////////
    ///
    ///
    BannerCubit bannerCubit = BlocProvider.of<BannerCubit>(context);
    ////////
    ///
    ///
    ///
    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) {
        ///////////
        ///
        ///
        ///
      },
      builder: (context, state) {
        List<BannerModel> banners = bannerCubit.banners;
        if (state is BannerLoadedState && banners.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 0.90,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.withOpacity(0.10)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: banner.imageUrl,
                              placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.30),
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                banner.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: whiteColor),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                banner.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: whiteColor),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
        return Container(
          height: 200,
          child: Shimmer.fromColors(
            baseColor: blackColor,
            highlightColor: whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoActivityIndicator(),
                  decoration: BoxDecoration(
                      color: greyColor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        );
      },
    );
  }
}
