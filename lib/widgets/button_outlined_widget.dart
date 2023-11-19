import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';

class ButtonOutlinedWidget extends StatelessWidget {
  final String? actionText;
  final VoidCallback? onTap;

  const ButtonOutlinedWidget({Key? key, this.actionText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(paddingDefault),
          border: Border.all(
            color: backgroundBaseApp,
            width: 1.5,
          ),
        ),
        child: Align(
          alignment: const Alignment(0, 0),
          child: Text(
            actionText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: backgroundBaseApp,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
