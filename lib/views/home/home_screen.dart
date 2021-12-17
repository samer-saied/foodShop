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

              ///////////////////    Temp Model Product ////////////////////
              // ProductCardWidget(
              //   product: ProductModel(
              //       productId: "productId",
              //       categoryId: "categoryId",
              //       currentPrice: {"sample": "400"},
              //       prePrice: {"sample": "400"},
              //       status: "new",
              //       imageUrl:
              //           "https://storage.eu.content-cdn.io/cdn-cgi/image/width=300,height=300,quality=75,format=auto,fit=cover,g=top/am-resources/b43a9bb3-260a-4e1f-9be6-65a809fab6e1/Images/ProductImages/Source/Eg-Mnstr-cmbo.png",
              //       title: "title Sandwitch fdfd",
              //       description: "description  alot of some word here",
              //       available: ''),
              // ),
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
