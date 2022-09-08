import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String? label;
  IconData? prefix;
  IconData? suffix;
  String? hint;
  Function? submit;
  Function? changed;
  Function? validate;
  VoidCallback? tap;
  VoidCallback? suffixPressed;
  TextEditingController? controller;
  bool suggestions;
  TextInputType? type;
  bool isPassword;
  TextStyle? labelStyle;
  TextStyle? hintStyle;
  InputBorder? border;
  String? errorText;
  int? maxLines;
  int? maxLength;
  bool? showCursor;
  bool readOnly;

  CustomTextFormField({
    this.border,
    this.changed,
    this.controller,
    this.errorText,
    this.hint,
    this.hintStyle,
    this.isPassword = false,
    this.label,
    this.labelStyle,
    this.prefix,
    this.submit,
    this.suffix,
    this.suffixPressed,
    this.suggestions = true,
    this.tap,
    this.type,
    this.validate,
    this.maxLength,
    this.maxLines,
    this.showCursor,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        hintStyle: hintStyle,
        prefixIcon: prefix != null ? Icon(prefix) : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        hintText: hint,
        border: border,
      ),
      //textAlignVertical: TextAlignVertical.center,
      showCursor: showCursor,
      onFieldSubmitted: (value) {
        if (submit != null) {
          submit!(value);
        }
      },
      onChanged: (value) {
        if (changed != null) {
          changed!(value);
        }
      },
      validator: (value) {
        if (validate != null) {
          return validate!(value);
        }
      },
      onTap: tap,
      controller: controller,
      enableSuggestions: suggestions,
      keyboardType: type,
      obscureText: isPassword,
      style: labelStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
    );
  }
}
