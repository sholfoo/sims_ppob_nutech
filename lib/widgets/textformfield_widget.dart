import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';

class TextFormFieldWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TextFormFieldWidget({
    this.controller,
    this.textHint,
    this.inputType,
    this.obsecureText = false,
    this.maxLines,
    this.iconData,
    this.readOnly,
  })  : assert(controller != null),
        assert(textHint != null);

  final TextEditingController? controller;
  final String? textHint;
  final TextInputType? inputType;
  final bool obsecureText;
  final int? maxLines;
  final IconData? iconData;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      style: const TextStyle(
        color: baseTextBlackLight,
        fontSize: 14,
      ),
      maxLines: maxLines,
      keyboardType: inputType,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: textHint,
        labelStyle: const TextStyle(
          color: Colors.black38,
        ),
        hintStyle: const TextStyle(color: backgroundBaseDark, fontSize: 14),
        contentPadding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: backgroundBaseDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: backgroundBaseApp,
            width: 1.5,
          ),
        ),
        prefixIcon: Icon(
          iconData,
          color: backgroundBaseDark,
        ),
      ),
      validator: (String? value) {
        return value!.isEmpty ? 'This field is required' : null;
      },
    );
  }
}
