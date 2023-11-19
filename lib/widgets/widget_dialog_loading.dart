import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogLoading extends StatelessWidget {
  final Color dialogColor;
  const DialogLoading({super.key, required this.dialogColor});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 120),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 0.0,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Wrap(
      children: [
        Container(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: SpinKitChasingDots(
                color: dialogColor,
                size: 60.0,
              ),
            ))
      ],
    );
  }
}
