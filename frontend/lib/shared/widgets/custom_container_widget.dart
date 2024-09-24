
import 'package:dashboard/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget(
      {super.key,
      required this.child,
      this.height,
      this.borderRadius,
      this.onTap});
  final Widget child;
  final double? height;
  final double? borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: Container(
            width: width,
            height: height != null ? width * height! : null,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: colorblack.withOpacity(0.1),
                  ),
                ],
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                color: colorwhite),
            child: child),
      ),
    );
  }
}
