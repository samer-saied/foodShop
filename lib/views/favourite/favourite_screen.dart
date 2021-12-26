import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/fav/userfav_cubit.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';
import 'package:onlinefooddeliverysystem/views/components/standard_products_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserfavCubit>(context).getLocalFavIDs();
    BlocProvider.of<UserfavCubit>(context).getLocalFavProducts(context);

    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      //////////////////////// List of Products ////////////////////////
      BlocBuilder<UserfavCubit, UserfavState>(
        builder: (context, state) {
          if (state is FavloadedState)
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ProductCardListWidget(
                      currencyCode: 'EGP',
                      products: context.read<UserfavCubit>().favProducts,
                      addCartEnabled: true,
                      dissmissEnabled: false,
                      favEnabled: false,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 10,
                  )
                ],
              ),
            );
          return Center(child: CupertinoActivityIndicator());
        },
      ),
      //////////////////////// App Bar ////////////////////////
      TitleSliderWidget(
        titleTxt: 'Favourite',
        prefixIcon: Icon(
          CupertinoIcons.heart_fill,
          color: whiteColor,
        ),
        backAvaiable: false,
      ),
    ]));
  }
}
