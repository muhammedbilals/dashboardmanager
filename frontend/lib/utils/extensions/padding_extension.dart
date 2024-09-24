import 'package:flutter/widgets.dart';

extension PaddingExtension on Widget {
  // All sides padding
  Padding paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  // Symmetric padding
  Padding paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  // Only padding
  Padding paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}