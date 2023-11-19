import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';

class TextFormPassWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? textHint;
  const TextFormPassWidget({
    super.key,
    this.controller,
    this.textHint,
  });

  @override
  State<TextFormPassWidget> createState() => _TextFormPassWidgetState();
}

class _TextFormPassWidgetState extends State<TextFormPassWidget> {
  bool? _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      controller: widget.controller,
      style: const TextStyle(
        color: baseTextBlackLight,
        fontSize: 14,
      ),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.textHint,
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
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: backgroundBaseDark,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible!;
            });
          },
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible! ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF858585),
          ),
        ),
      ),
      validator: (String? value) {
        return value!.isEmpty ? 'This field is required' : null;
      },
      obscureText: !_passwordVisible!,
    );
  }
}
