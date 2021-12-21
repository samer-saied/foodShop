import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/themes.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';

import 'controllers/banner/banner_cubit.dart';
import 'views/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BannerCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider<ProductCubit>(
          //lazy: false,
          create: (context) => ProductCubit()..getProducts(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'food Shop',
          theme: ThemesStyle().defaultThemeStyle,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
