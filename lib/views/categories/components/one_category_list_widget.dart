import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

class OneCategoryListView extends StatelessWidget {
  final String categoryID;
  const OneCategoryListView({Key? key, required this.categoryID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context)
      ..getSelectedProductByCategory(categoryId: categoryID);
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (productCubit.selectedProductByCat.isNotEmpty) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, int separator) =>
                          const Divider(),
                      itemCount: productCubit.selectedProductByCat.length,
                      itemBuilder: (context, int index) {
                        return SingleProductCardWidget(
                          product: productCubit.selectedProductByCat[index],
                          currencyCode: 'EGP',
                          favEnabled: true,
                        );
                      },
                    )),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 10,
                )
              ],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.exclamationmark_circle),
              Text("No Products for selected Category.."),
            ],
          ),
        );
      },
    );
  }
}
