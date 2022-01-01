import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

//////////////////////////    Product Cards List for Selected Category    /////////////////////////////////

class CategoryProductsWidget extends StatelessWidget {
  const CategoryProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);

    return BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductloadedState) {
            print("--------------Products-done---------------");
            productCubit.getSelectedProduct(
                categoryId:
                    BlocProvider.of<CategoryCubit>(context).selectedItem);
          }
        },
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (BlocProvider.of<ProductCubit>(context)
                .selectedProduct
                .isEmpty) {
              productCubit.getSelectedProduct(
                  categoryId:
                      BlocProvider.of<CategoryCubit>(context).selectedItem);
            }
          },
          builder: (context, state) {
            if ((state is CategorychangeLoadedSuccessState ||
                    state is CategoryLoadedSuccessState) &&
                productCubit.selectedProduct.isNotEmpty) {
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, int separator) =>
                        const Divider(),
                    itemCount: productCubit.selectedProduct.length,
                    itemBuilder: (context, int index) {
                      return SingleProductCardWidget(
                        product: productCubit.selectedProduct[index],
                        currencyCode: 'EGP',
                        favEnabled: true,
                      );
                    },
                  ));
            }
            if (productCubit.selectedProduct.isEmpty) {
              return Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.exclamationmark_circle),
                      Text("No Products for selected Category.."),
                    ],
                  ),
                ),
              );
            }

            return Center(child: CupertinoActivityIndicator());
          },
        ));
  }
}
