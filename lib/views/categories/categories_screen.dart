import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';

import 'components/category_card_widget.dart';

class CategoriesGridScreen extends StatelessWidget {
  const CategoriesGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit = BlocProvider.of<CategoryCubit>(context);
    return Scaffold(
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 3
                      : 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: categoryCubit.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategoryCardWidget(
                    category: categoryCubit.categories[index],
                  );
                }),
          );
        },
      ),
    );
  }
}
