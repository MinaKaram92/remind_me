import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String? value)? changed;
  final String? Function(String? value)? validate;
  final String? hint;
  final TextStyle? style;
  final Color? dropDownColor;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.items,
    required this.changed,
    this.value,
    this.hint,
    this.validate,
    this.style,
    this.dropDownColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      value: value,
      dropdownColor: dropDownColor,
      onChanged: (String? value) {
        changed!(value!);
      },
      validator: (String? value) {
        if (validate != null) {
          return validate!(value);
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      hint: hint != null ? Text(hint!) : null,
      decoration: const InputDecoration(border: InputBorder.none),
      style: style,
    );
  }
}
