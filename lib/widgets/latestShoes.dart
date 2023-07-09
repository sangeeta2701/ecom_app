import 'package:ecom_app/widgets/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/snekers.dart';



class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Snekers>> male,
  }) : _male = male;

  final Future<List<Snekers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Snekers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.extent(
                        (index % 2 == 0) ? 1 : 1,
                        (index % 4 == 1 || index % 4 == 3)
                            ? MediaQuery.of(context).size.height *
                                0.35
                            : MediaQuery.of(context).size.height *
                                0.3),
                itemCount: male!.length,
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: "\$${shoe.price}");
                });
          }
        });
  }
}
