import 'package:flutter/material.dart';

///TextField widget used as input methode to be used across application
class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.textInputAction,
    required this.textInputType,
    this.textEditingController,
    this.validator,
    required this.autofillHints,
    this.isSecondaryStyle = false,
    this.isEnabled = true,
    this.icon,
    this.initialValue,
    this.onTap,
    this.readOnly = false,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.obscureText = false,
    this.enableSuggestions = false,
  });

  final String labelText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final Iterable<String> autofillHints;
  final bool isSecondaryStyle;
  final bool? isEnabled;
  final IconData? icon;
  final IconData? suffixIcon;
  final String? initialValue;
  final void Function()? onTap;
  final bool readOnly;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final bool enableSuggestions;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;
  bool _hasTyped = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onChanged(String value) {
    setState(() {
      _hasTyped = value.isNotEmpty;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        onTap: widget.onTap,
        onChanged: _onChanged,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        enableSuggestions: widget.enableSuggestions,
        enabled: widget.isEnabled,
        obscureText: _obscureText,
        validator: widget.validator,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          icon: !widget.isSecondaryStyle || widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  size: 22,
                ),
          isDense: true,
          label: Text(widget.labelText),
          hintText: widget.hintText,
          suffixIcon: widget.obscureText && _hasTyped
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                )
              : Icon(widget.suffixIcon),
          hintStyle: const TextStyle(fontSize: 14),
          floatingLabelBehavior: widget.isSecondaryStyle
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: widget.isSecondaryStyle
              ? const UnderlineInputBorder()
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
        ),
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        controller: widget.textEditingController,
      ),
    );
  }
}