import 'package:ecom_app/controllers/mainscreen_provider.dart';
// import 'package:ecom_app/screens/cart_screen.dart';
import 'package:ecom_app/screens/home_screen.dart';
import 'package:ecom_app/screens/profile_screen.dart';
import 'package:ecom_app/screens/search_screen.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList =  [
    HomeScreen(),
    SearchScreen(),
    HomeScreen(),
    Cart(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // int pageIndex = 1;
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: bgColor,
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: bColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomNavWidget(
                    ontap: () {
                      mainScreenNotifier.pageIndex = 0;
                    },
                    icon:mainScreenNotifier.pageIndex == 0 ? Icons.home: Icons.home_outlined),
                bottomNavWidget(
                    ontap: () {
                      mainScreenNotifier.pageIndex = 1;
                    },
                    icon:mainScreenNotifier.pageIndex == 1? Icons.search:Icons.search),
                bottomNavWidget(
                    ontap: () {
                      mainScreenNotifier.pageIndex = 2;
                    },
                    icon:mainScreenNotifier.pageIndex == 2? Icons.add:Icons.add),
                bottomNavWidget(
                    ontap: () {
                      mainScreenNotifier.pageIndex = 3;
                    },
                    icon:mainScreenNotifier.pageIndex == 3? Icons.shopping_cart: Icons.shopping_cart_outlined),
                bottomNavWidget(ontap: () {
                  mainScreenNotifier.pageIndex = 4;
                }, icon:mainScreenNotifier.pageIndex == 4? Icons.person: Icons.person_outlined),
              ],
            ),
          ),
        )),
        body: pageList[mainScreenNotifier.pageIndex],
      );
    });
  }
}
