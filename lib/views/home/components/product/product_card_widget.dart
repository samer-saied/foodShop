import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/details/details_product_main_screen.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  const ProductCardWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);
    return Container(
      // width: mediaQueryize.size.width * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsProductScreen(product: product)));
        },
        child: Stack(
          alignment: Alignment.topCenter,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /////////// Product Image ////////////
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            /////////// Product Name ////////////
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 2, left: 2),
              child: Text(
                product.title.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: mediaQueryize.orientation == Orientation.portrait
                    ? Theme.of(context).textTheme.headline6
                    : Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
