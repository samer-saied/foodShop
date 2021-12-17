import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';

import 'details_landScape_product.dart';
import 'details_portrait_product.dart';

class DetailsProductScreen extends StatelessWidget {
  final ProductModel product;
  const DetailsProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait
        ? DetailsPortraitViewWidget(
            product: product,
          )
        : DetailsLandscapeProductView(
            product: product,
          );
  }
}
