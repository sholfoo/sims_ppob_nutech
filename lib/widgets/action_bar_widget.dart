import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';

class ActionBarWidget extends StatefulWidget {
  final String actionBarTitle;
  final VoidCallback onActionBackToDashboard;
  const ActionBarWidget({
    super.key,
    required this.actionBarTitle,
    required this.onActionBackToDashboard,
  });

  @override
  State<ActionBarWidget> createState() => _ActionBarWidgetState();
}

class _ActionBarWidgetState extends State<ActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: paddingWide, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeight32,
          Stack(
            children: [
              InkWell(
                onTap: widget.onActionBackToDashboard,
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    spaceWidth5,
                    Text(
                      'Kembali',
                      style: TextStyle(
                        height: 1,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Text(
                  widget.actionBarTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    height: 1,
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
