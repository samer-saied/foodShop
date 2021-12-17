import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';

import 'components/app_brand.dart';
import 'components/banner_widget.dart';
import 'components/categories_widget.dart';
import 'components/gridview_product_widget.dart';
import 'components/label_title_widget.dart';
import 'components/products_standard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: whiteColor,
      color: mainColor,
      onRefresh: () async {
        BlocProvider.of<ProductCubit>(context).getProductsForce();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AppBrand(),
              BannerWidget(),
              ///////////////////    Top Products Section ////////////////////
              SizedBox(
                height: 5,
              ),
              LabelTitleWidget(
                title: "Top Products",
                seeAllEnabled: true,
                onTapSeeAll: () {
                  print("samer");
                },
              ),
              GridViewCardProductWidget(),
              ///////////////////   Standard Products Section  ////////////////////
              SizedBox(
                height: 10,
              ),
              LabelTitleWidget(
                title: "Products",
                seeAllEnabled: true,
                onTapSeeAll: () {
                  print("samer");
                },
              ),
              SizedBox(
                height: 10,
              ),
              CategoriesWidget(),
              SizedBox(
                height: 10,
              ),
              StandardProductsWidget(),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
