import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';

class AddCartDetailsWidget extends StatelessWidget {
  const AddCartDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("add to cart");
      },
      child: Container(
        //width: MediaQuery.of(context).size.width * .10,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart,
                color: whiteColor,
                // size: 14,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("add to Cart",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      // fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: whiteColor)),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFavDetailsWidget extends StatelessWidget {
  const AddFavDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Like");
      },
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: mainColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                color: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
