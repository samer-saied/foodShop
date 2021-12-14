import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ////////
    ///
    ///
    CategoryCubit categoryCubit = BlocProvider.of<CategoryCubit>(context)
      ..getCategories();

    ////////
    ///
    ///
    ///
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        ///////////
        ///
        ///
        ///
      },
      builder: (context, state) {
        if (state is CategoryLoadedSuccessState ||
            state is CategoryChangeSelectedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: categoryCubit.categories.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, int selectedItem) {
                    return CategoryLabel(
                        active: selectedItem == categoryCubit.selectedItem
                            ? true
                            : false,
                        selected: selectedItem,
                        title: categoryCubit.categories[selectedItem].title);
                  }),
            ),
          );
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}

class CategoryLabel extends StatelessWidget {
  final int selected;
  final bool active;
  final String title;
  CategoryLabel(
      {Key? key,
      required this.active,
      required this.title,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<CategoryCubit>(context)
              .changeSelectedItem(itemId: selected);
        },
        child: Container(
          width: 90,
          decoration: BoxDecoration(
              color: active ? mainColor : whiteColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 1,
                color: active ? whiteColor : mainColor,
              )),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                color: active ? whiteColor : mainColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
