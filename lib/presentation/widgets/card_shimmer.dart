import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(3.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.7,
              child: Container(
                width: 150,
                height: 270,
                padding: const EdgeInsets.all(10.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
