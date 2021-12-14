import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';

class AppBrand extends StatelessWidget {
  const AppBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
                height: 30,
                width: 30,
                imageUrl:
                    "https://freeiconshop.com/wp-content/uploads/edd/hotdog-outline-filled.png"),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "food Shop",
              style: TextStyle(
                color: mainColor,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
