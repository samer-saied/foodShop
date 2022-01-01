import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/models/category_model.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';

import 'components/one_category_list_widget.dart';

class OneCategoryScreen extends StatelessWidget {
  const OneCategoryScreen({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ///
          //////////////////////// List of Products for One Category ////////////////////////
          OneCategoryListView(
            categoryID: category.categoryId,
          ),

          ///
          //////////////////////// Red Banner - title & Back button - ////////////////////////
          TitleSliderWidget(
            titleTxt: category.title,
            prefixIcon: SizedBox(),
            backAvaiable: true,
          ),
        ],
      ),
    );
  }
}
