import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/fav/fav_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late FavBloc userfavBloc;

  @override
  void initState() {
    userfavBloc = BlocProvider.of<FavBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    userfavBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userfavBloc.add(LoadFavProductEvent(context.read<ProductCubit>().products));
    List<ProductModel> favProducts = userfavBloc.favProducts;
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      //////////////////////// List of FAV Products ////////////////////////
      BlocBuilder<FavBloc, FavState>(builder: (context, state) {
        if (state is FavloadingState) {
          return Center(child: CupertinoActivityIndicator());
        }
        if ((state is FavloadedState ||
                state is FavInitialCompeleteState ||
                state is FavcheckCompelteState ||
                state is FavtoggleCompelteState) &&
            userfavBloc.favProducts.isNotEmpty) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favProducts.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (dismissDirection) {
                              favProducts.remove(favProducts[index].productId);
                              userfavBloc.add(ToggleFavProductEvent(
                                  favProducts[index].productId));
                              setState(() {
                                // favProducts =
                                //     context.read<FavBloc>().favProducts;
                              });
                            },
                            background: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Remove",
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                //  borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: SingleProductCardWidget(
                              product: favProducts[index],
                              currencyCode: 'EGP',
                              favEnabled: false,
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 10,
                )
              ],
            ),
          );
        } else {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.exclamationmark_circle),
                SizedBox(
                  height: 5,
                ),
                Text('No favourite products'),
              ],
            ),
          );
        }
      }),
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
