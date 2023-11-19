import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';

class ButtonFillWidget extends StatelessWidget {
  final String? actionText;
  final VoidCallback? onTap;
  final Color? buttonColor;

  const ButtonFillWidget(
      {Key? key, this.actionText, this.onTap, this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
        height: 48,
        decoration: BoxDecoration(
          color: buttonColor ?? backgroundBaseApp,
          borderRadius: BorderRadius.circular(paddingDefault),
        ),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Text(
            actionText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: baseTextWhite,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
