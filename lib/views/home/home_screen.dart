import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/allproducts/all_products_widget.dart';

import 'components/app_brand.dart';
import 'components/banner_widget.dart';
import 'components/category/categories_list_widget.dart';
import 'components/category/category_products_Widget.dart';
import '../app/components/label_title_widget.dart';
import 'components/product/gridview_product_widget.dart';

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
              ///////////////////  Category Section  ////////////////////
              SizedBox(
                height: 10,
              ),
              LabelTitleWidget(
                title: "Products",
                seeAllEnabled: true,
                onTapSeeAll: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllProductsWidget()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              CategoriesWidget(),
              ///////////////////   Standard Products Section  ////////////////////
              SizedBox(
                height: 10,
              ),
              CategoryProductsWidget(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
