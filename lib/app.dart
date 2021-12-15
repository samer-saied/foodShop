import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
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
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'food Shop',
          theme: ThemeData(
            fontFamily: 'Cairo',
            primarySwatch: Colors.red,
            textTheme: const TextTheme(
              subtitle1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              subtitle2: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                // color: greyColor,
              ),
              headline1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: blackColor,
              ),
              headline2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: blackColor,
              ),
              headline3: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: blackColor,
              ),
              headline4: TextStyle(
                fontSize: 16,
                color: blackColor,
              ),
              headline5: TextStyle(
                fontSize: 14,
                color: blackColor,
              ),
              headline6: TextStyle(
                fontSize: 12,
                color: blackColor,
              ),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
