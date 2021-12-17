import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/home/components/new_product_widget.dart';

class GridViewCardProductWidget extends StatelessWidget {
  const GridViewCardProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);

    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context)
      ..getNewProducts();

    return Container(
      height: mediaQueryize.orientation == Orientation.portrait
          ? (mediaQueryize.size.height * 0.30) + 15.0
          : (mediaQueryize.size.height * 0.70) + 15.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProductloadedState) {
                return Row(
                  children: [
                    ////////////////////////     NEW PRODUCTS       /////////////////////////////////
                    Row(
                        children: productCubit.newProducts
                            .map((product) =>
                                NewProductsWidget(product: product))
                            .toList()),
                    ////////////////////////     TOP PRODUCTS       /////////////////////////////////
                    Row(
                        children: productCubit.newProducts
                            .map((product) =>
                                NewProductsWidget(product: product))
                            .toList()),
                  ],
                );
              }
              return const Center(child: CupertinoActivityIndicator());
            },
          )),
    );
  }
}
