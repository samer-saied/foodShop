import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/themes.dart';
import 'package:onlinefooddeliverysystem/controllers/cart/cart_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';
import 'package:onlinefooddeliverysystem/controllers/fav/fav_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/tab_bar_widget.dart';

import 'controllers/banner/banner_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BannerCubit()..getBanners(),
        ),
        BlocProvider<ProductCubit>(
          //lazy: false,
          create: (context) => ProductCubit()..getProducts(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..getCategories(),
        ),
        BlocProvider(
          create: (context) => FavBloc()..add(FavInitEvent()),
        ),
        BlocProvider(create: (context) => CartBloc()..add(CartInitEvent())),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'food Shop',
          theme: ThemesStyle().defaultThemeStyle,
          home: TabBarWidget(),
        ),
      ),
    );
  }
}
