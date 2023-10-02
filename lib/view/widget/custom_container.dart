import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    required this.shape,
    required this.buttonText,
  });
  final void Function()? onTap;
  final double width;
  final double height;
  final BoxShape shape;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          color: kWhiteColor,
          border: Border.all(width: 0.5),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: kBlackColor,
            ),
          ),
        ),
      ),
    );
  }
}