
import 'package:dashboard/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioWidget extends StatefulWidget {
  RadioWidget(
      {super.key,
      required this.onChanged,
      required this.option,
      required this.title,
      this.selectedOption});
  void Function(dynamic)? onChanged;
  final List<String> option;
  final String? selectedOption;
  final String title;
  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  late String select;

  @override
  void initState() {
    super.initState();
    select = widget.selectedOption ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Text(widget.title,
              style:
                  TextStyle(fontSize: 13, color: colorblack.withOpacity(0.6))),
        ),
        Row(children: [
          Icon(Icons.person, color: colorblack.withOpacity(0.5)),
          addRadioButton(0, widget.option[0], widget.option),
          addRadioButton(1, widget.option[1], widget.option)
        ]),
      ],
    );
  }

  Row addRadioButton(int btnValue, String title, List<String> option) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: colorred,
          value: option[btnValue],
          groupValue: select,
          onChanged: (value) {
            widget.onChanged!(value);
            setState(() {
              print(value);
              select = value!;
            });
          },
        ),
        Text(title)
      ],
    );
  }
}
