import 'package:flutter/cupertino.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/views/cart/cart_screen.dart';
import 'package:onlinefooddeliverysystem/views/favourite/favourite_screen.dart';
import 'package:onlinefooddeliverysystem/views/home/home_screen.dart';
import 'package:onlinefooddeliverysystem/views/user/login_screen.dart';

import 'categories/categories_screen.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    //   return LoginScreen();
    // }
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: mainColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.circle_grid_3x3,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart_fill,
            ),
            label: 'favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
            ),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                {
                  return HomeScreen();
                }
              case 1:
                {
                  return CategoriesGridScreen();
                }
              case 2:
                {
                  return CartScreen();
                }
              case 3:
                {
                  return FavouriteScreen();
                }
              case 4:
                {
                  return LoginScreen();
                }
            }

            return Center(child: CupertinoActivityIndicator());
          },
        );
      },
    );
  }
}
