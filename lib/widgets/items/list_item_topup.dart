import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';

class ListItemTopup extends StatefulWidget {
  final int topupValue;
  final Function(int) onSelectedNominal;
  const ListItemTopup(
      {super.key, required this.topupValue, required this.onSelectedNominal});

  @override
  State<ListItemTopup> createState() => _ListItemTopupState();
}

class _ListItemTopupState extends State<ListItemTopup> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelectedNominal(widget.topupValue);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(
            color: backgroundBaseDark,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            rupiah(widget.topupValue),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
