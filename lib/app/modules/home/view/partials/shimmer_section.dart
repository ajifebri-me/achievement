import 'package:achievement/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSection extends StatelessWidget {
  const ShimmerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Shimmer.fromColors(
              baseColor: Const.baseColorShimmer,
              highlightColor: Const.highlightColorShimmer,
              child: Container(
                width: Get.width,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Const.baseColorShimmer,
            highlightColor: Const.highlightColorShimmer,
            child: Container(
              width: Get.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Const.baseColorShimmer,
            highlightColor: Const.highlightColorShimmer,
            child: Container(
              width: Get.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
