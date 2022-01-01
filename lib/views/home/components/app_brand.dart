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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/brand/brandicon.png'),
              height: 30,
            ),
            // CachedNetworkImage(
            //     height: 30,
            //     width: 30,
            //     imageUrl:
            //         "https://freeiconshop.com/wp-content/uploads/edd/hotdog-outline-filled.png"),
            const SizedBox(
              width: 10,
            ),
            Text(
              "food Shop",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: mainColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
