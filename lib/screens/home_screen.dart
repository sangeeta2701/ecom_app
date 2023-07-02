import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_img1.png"),
                    fit: BoxFit.fill)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shoes",
                      style: appStyleWithHt(42, wColor, FontWeight.bold, 1.2),
                    ),
                    Text(
                      "Collection",
                      style: appStyleWithHt(42, wColor, FontWeight.bold, 1.2),
                    )
                  ]),
            ),
          ),
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            controller: _tabController,
            isScrollable: true,
            labelStyle: appStyle(24, wColor, FontWeight.bold),
            tabs: [
            Tab(text: "Mens Shoes",),
            Tab(text: "Womens Shoes",),
            Tab(text: "kids Shoes",),
          ],),
          TabBarView(
            controller: _tabController,
            children: [],),
        ],
      ),
    ));
  }
}
