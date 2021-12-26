import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/category_model.dart';

import '../one_category_screen.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OneCategoryScreen(
              category: category,
            ),
          ),
        );
      },
      child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: blackColor,
          color: backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //////////////////////////////   Image   /////////////////////////////////////////
              category.imageUrl.isEmpty
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        child: Image(
                          image: AssetImage(
                              "assets/images/No_image_available.png"),
                        ),
                      ))
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            top: 0,
                            left: 0,
                            right: 0,
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [CupertinoActivityIndicator()],
                              ),
                              imageUrl: category.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: blackColor.withOpacity(.30),
                          )
                        ],
                      ),
                    ),
              //////////////////////////////   Title   /////////////////////////////////////////
              Positioned(
                top: 10,
                child: Container(
                    decoration: BoxDecoration(
                      color: blackColor.withOpacity(0.60),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5, top: 5, right: 15, left: 15),
                      child: Text(
                        category.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: whiteColor),
                      ),
                    )),
              ),
              //////////////////////////////   Description   /////////////////////////////////////////
              category.description.isEmpty
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: blackColor.withOpacity(0.40),
                            // borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, top: 5, right: 15, left: 15),
                            child: Text(
                              category.description,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: whiteColor,
                                      fontWeight: FontWeight.normal),
                            ),
                          )),
                    )
            ],
          )),
    );
  }
}
