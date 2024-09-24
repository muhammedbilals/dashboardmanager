
import 'package:dashboard/core/colors/colors.dart';
import 'package:flutter/material.dart';



///devider widget to use in signin and signup pages
class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: colorblack.withOpacity(0.5),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  fontSize: 13,
                  color: colorblack.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 1,
                color: colorblack.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
