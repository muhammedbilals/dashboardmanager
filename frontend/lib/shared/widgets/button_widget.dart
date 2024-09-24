import 'dart:developer';


import 'package:dashboard/core/colors/colors.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';
import 'package:flutter/material.dart';

///common button widget
///
///color and size of the button can be changed by passong color and width parameter

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      this.navigation,
      this.color,
      this.width,
      this.onPressed,
      this.isPushreplacement,
      this.formKey,
      this.isLoading,
      this.borderRadius,
      this.buttonColor,
      this.borderColor,
      this.buttonStatus});

  final String text;
  final Widget? navigation;
  final Color? color;
  final Color? buttonColor;
  final Color? borderColor;
  final ButtonStatus? buttonStatus;

  final double? width;
  // final Future? onPressed;
  final bool? isPushreplacement;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final width1 = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: width1 * 0.12,
        width: width,
        child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: borderColor != null
                      ? BorderSide(color: borderColor!)
                      : const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(
                      borderRadius != null ? borderRadius! : 10),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll<Color>(
                  color != null ? color! : colorred),
            ),
            onPressed: () {
              log('button clicked');
              if (formKey != null) {
                final isFormValid = formKey!.currentState!.validate();
                if (!isFormValid) {
                  return;
                }
              }
              if (onPressed != null) {
                onPressed!();
                log('methode executed');
              }
              if (isPushreplacement != true && navigation != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => navigation!,
                  ),
                );
              } else if (isPushreplacement == true && navigation != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => navigation!,
                  ),
                );
              }
            },
            child: _buttonState()),
      ),
    );
  }

  Widget _buttonState() {
    switch (buttonStatus) {
      case ButtonStatus.loading:
        return CircularProgressIndicator(
          color: colorred.withOpacity(0.5),
          strokeWidth: 4,
        );
      case ButtonStatus.error:
        return const Icon(
          Icons.error_outline_outlined,
          color: colorred,
        );
      case ButtonStatus.idle:
      default:
        return Text(
          text,
          style: TextStyle(
            color: buttonColor ?? colorwhite,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );
    }
  }
}
