import 'package:flutter/material.dart';


///Safearea that is used across all of the pages in the app
///
///Return [Color] to match the Current screen
class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).colorScheme.surface,
      
      child: SafeArea(
        bottom: true,
         
        child: child,
      ),
    );
  }
}
